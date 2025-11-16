import 'package:flutter/material.dart';
import '../models/medication.dart';
import '../services/database_service.dart';
import '../widgets/medication_card.dart';
import '../widgets/add_medication_dialog.dart';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  late Future<List<Medication>> _medicationsFuture;
  final DatabaseService _databaseService = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadMedications();
  }

  void _loadMedications() {
    setState(() {
      _medicationsFuture = _databaseService.getMedications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medications'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              // TODO: Navigate to medication reminders
            },
            tooltip: 'Reminders',
          ),
        ],
      ),
      body: FutureBuilder<List<Medication>>(
        future: _medicationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final medications = snapshot.data ?? [];

          if (medications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.medication,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No medications added yet',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap + to add your first medication',
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
            itemCount: medications.length,
            itemBuilder: (context, index) {
              final medication = medications[index];
              return MedicationCard(
                medication: medication,
                onDelete: () async {
                  await _databaseService.deleteMedication(medication.id!);
                  _loadMedications();
                },
                onToggleTaken: () async {
                  await _databaseService.updateMedication(
                    medication.copyWith(
                      isTaken: !medication.isTaken,
                      lastTaken: !medication.isTaken ? DateTime.now() : null,
                    ),
                  );
                  _loadMedications();
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddMedicationDialog,
        child: const Icon(Icons.add),
        tooltip: 'Add Medication',
      ),
    );
  }

  void _showAddMedicationDialog() async {
    final result = await showDialog<Medication>(
      context: context,
      builder: (context) => const AddMedicationDialog(),
    );

    if (result != null) {
      await _databaseService.insertMedication(result);
      _loadMedications();
    }
  }
}