import 'package:flutter/material.dart';
import '../models/medication.dart';

class AddMedicationDialog extends StatefulWidget {
  const AddMedicationDialog({super.key});

  @override
  State<AddMedicationDialog> createState() => _AddMedicationDialogState();
}

class _AddMedicationDialogState extends State<AddMedicationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dosageController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _prescribedByController = TextEditingController();
  final _pharmacyController = TextEditingController();
  
  String _selectedFrequency = Medication.frequencies.first;
  DateTime _selectedStartDate = DateTime.now();
  DateTime? _selectedEndDate;
  bool _hasEndDate = false;

  @override
  void dispose() {
    _nameController.dispose();
    _dosageController.dispose();
    _instructionsController.dispose();
    _prescribedByController.dispose();
    _pharmacyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Medication'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Medication Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter medication name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dosageController,
                decoration: const InputDecoration(
                  labelText: 'Dosage',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., 10mg, 1 tablet',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter dosage';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedFrequency,
                decoration: const InputDecoration(
                  labelText: 'Frequency',
                  border: OutlineInputBorder(),
                ),
                items: Medication.frequencies.map((frequency) {
                  return DropdownMenuItem(
                    value: frequency,
                    child: Text(frequency),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrequency = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Start Date'),
                subtitle: Text(_formatDate(_selectedStartDate)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectStartDate,
              ),
              const SizedBox(height: 8),
              CheckboxListTile(
                title: const Text('Has end date'),
                value: _hasEndDate,
                onChanged: (value) {
                  setState(() {
                    _hasEndDate = value ?? false;
                    if (!_hasEndDate) {
                      _selectedEndDate = null;
                    }
                  });
                },
              ),
              if (_hasEndDate) ...[
                ListTile(
                  title: const Text('End Date'),
                  subtitle: Text(_selectedEndDate != null ? _formatDate(_selectedEndDate!) : 'Select end date'),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: _selectEndDate,
                ),
              ],
              const SizedBox(height: 16),
              TextFormField(
                controller: _instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Instructions (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Take with food',
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _prescribedByController,
                decoration: const InputDecoration(
                  labelText: 'Prescribed By (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _pharmacyController,
                decoration: const InputDecoration(
                  labelText: 'Pharmacy (Optional)',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _submitForm,
          child: const Text('Save'),
        ),
      ],
    );
  }

  Future<void> _selectStartDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() {
        _selectedStartDate = date;
      });
    }
  }

  Future<void> _selectEndDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedEndDate ?? DateTime.now().add(const Duration(days: 30)),
      firstDate: _selectedStartDate,
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );

    if (date != null) {
      setState(() {
        _selectedEndDate = date;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final medication = Medication(
        name: _nameController.text,
        dosage: _dosageController.text,
        frequency: _selectedFrequency,
        instructions: _instructionsController.text.isEmpty ? null : _instructionsController.text,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        prescribedBy: _prescribedByController.text.isEmpty ? null : _prescribedByController.text,
        pharmacy: _pharmacyController.text.isEmpty ? null : _pharmacyController.text,
      );

      Navigator.of(context).pop(medication);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}