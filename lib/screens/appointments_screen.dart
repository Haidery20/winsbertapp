import 'package:flutter/material.dart';
import '../models/appointment.dart';
import '../services/database_service.dart';
import '../widgets/appointment_card.dart';
import '../widgets/add_appointment_dialog.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  late Future<List<dynamic>> _appointmentsFuture;
  final InMemoryDatabase _databaseService = InMemoryDatabase();

  @override
  void initState() {
    super.initState();
    _loadAppointments();
  }

  void _loadAppointments() {
    setState(() {
      _appointmentsFuture = _databaseService.getAppointments();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: () {
              // TODO: Navigate to calendar view
            },
            tooltip: 'Calendar View',
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _appointmentsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final appointments = snapshot.data ?? [];

          if (appointments.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No appointments scheduled',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to schedule an appointment',
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
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = appointments[index];
              return AppointmentCard(
                appointment: appointment,
                onDelete: () async {
                  await _databaseService.deleteAppointment(appointment.id!);
                  _loadAppointments();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAppointmentDialog,
        child: const Icon(Icons.add),
        tooltip: 'Schedule Appointment',
      ),
    );
  }

  void _showAddAppointmentDialog() async {
    final result = await showDialog<Appointment>(
      context: context,
      builder: (context) => const AddAppointmentDialog(),
    );

    if (result != null) {
      await _databaseService.insertAppointment(result);
      _loadAppointments();
    }
  }
}