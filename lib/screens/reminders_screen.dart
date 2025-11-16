import 'package:flutter/material.dart';
import '../models/reminder.dart';
import '../services/database_service.dart';
import '../widgets/reminder_card.dart';
import '../widgets/pharmaserve_logo.dart';

class RemindersScreen extends StatefulWidget {
  const RemindersScreen({super.key});

  @override
  State<RemindersScreen> createState() => _RemindersScreenState();
}

class _RemindersScreenState extends State<RemindersScreen> {
  late Future<List<dynamic>> _remindersFuture;
  final InMemoryDatabase _databaseService = InMemoryDatabase();
  bool _showTodayOnly = true;

  @override
  void initState() {
    super.initState();
    _loadReminders();
  }

  void _loadReminders() {
    setState(() {
      _remindersFuture = _showTodayOnly 
          ? _databaseService.getTodayReminders()
          : _databaseService.getUpcomingReminders();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            PharmaServeLogo(size: 28, showText: false),
            const SizedBox(width: 10),
            const Text('Reminders'),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: Icon(_showTodayOnly ? Icons.today : Icons.calendar_today),
            onPressed: () {
              setState(() {
                _showTodayOnly = !_showTodayOnly;
                _loadReminders();
              });
            },
            tooltip: _showTodayOnly ? 'Show All Reminders' : 'Show Today Only',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).colorScheme.primaryContainer,
            child: Row(
              children: [
                PharmaServeLogo(size: 32, showText: false),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _showTodayOnly 
                        ? 'Today\'s medication reminders'
                        : 'Upcoming medication reminders',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: _remindersFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final reminders = snapshot.data ?? [];

                if (reminders.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 80,
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          _showTodayOnly 
                              ? 'No reminders for today'
                              : 'No upcoming reminders',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Add medications to create automatic reminders',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: reminders.length,
                  itemBuilder: (context, index) {
                    final reminder = reminders[index];
                    return ReminderCard(
                      reminder: reminder,
                      onMarkAsTaken: () async {
                        await _databaseService.updateReminder(
                          reminder.copyWith(
                            isTaken: true,
                            takenTime: DateTime.now(),
                          ),
                        );
                        _loadReminders();
                      },
                      onDelete: () async {
                        await _databaseService.deleteReminder(reminder.id!);
                        _loadReminders();
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}