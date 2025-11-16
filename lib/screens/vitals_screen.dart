import 'package:flutter/material.dart';
import '../models/vital.dart';
import '../services/database_service.dart';
import '../widgets/vital_card.dart';
import '../widgets/add_vital_dialog.dart';

class VitalsScreen extends StatefulWidget {
  const VitalsScreen({super.key});

  @override
  State<VitalsScreen> createState() => _VitalsScreenState();
}

class _VitalsScreenState extends State<VitalsScreen> {
  late Future<List<dynamic>> _vitalsFuture;
  final InMemoryDatabase _databaseService = InMemoryDatabase();

  @override
  void initState() {
    super.initState();
    _loadVitals();
  }

  void _loadVitals() {
    setState(() {
      _vitalsFuture = _databaseService.getVitals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vitals'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              // TODO: Navigate to vitals charts
            },
            tooltip: 'View Charts',
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _vitalsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final vitals = snapshot.data ?? [];

          if (vitals.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.monitor_heart,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No vitals recorded yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first vital reading',
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
            itemCount: vitals.length,
            itemBuilder: (context, index) {
              final vital = vitals[index];
              return VitalCard(
                vital: vital,
                onDelete: () async {
                  await _databaseService.deleteVital(vital.id!);
                  _loadVitals();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVitalDialog,
        child: const Icon(Icons.add),
        tooltip: 'Add Vital Reading',
      ),
    );
  }

  void _showAddVitalDialog() async {
    final result = await showDialog<Vital>(
      context: context,
      builder: (context) => const AddVitalDialog(),
    );

    if (result != null) {
      await _databaseService.insertVital(result);
      _loadVitals();
    }
  }
}