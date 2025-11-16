import 'package:flutter/material.dart';
import '../models/vital.dart';

class AddVitalDialog extends StatefulWidget {
  const AddVitalDialog({super.key});

  @override
  State<AddVitalDialog> createState() => _AddVitalDialogState();
}

class _AddVitalDialogState extends State<AddVitalDialog> {
  final _formKey = GlobalKey<FormState>();
  final _valueController = TextEditingController();
  final _notesController = TextEditingController();
  
  String _selectedType = Vital.vitalTypes.first;
  String _selectedUnit = Vital.vitalUnits[Vital.vitalTypes.first]!;
  DateTime _selectedDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _selectedUnit = Vital.vitalUnits[_selectedType]!;
  }

  @override
  void dispose() {
    _valueController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Vital Reading'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Vital Type',
                  border: OutlineInputBorder(),
                ),
                items: Vital.vitalTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                    _selectedUnit = Vital.vitalUnits[_selectedType]!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _valueController,
                      decoration: InputDecoration(
                        labelText: 'Value',
                        border: const OutlineInputBorder(),
                        suffixText: _selectedUnit,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Date & Time'),
                subtitle: Text(_formatDateTime(_selectedDateTime)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDateTime,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
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

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final vital = Vital(
        type: _selectedType,
        value: _valueController.text,
        unit: _selectedUnit,
        timestamp: _selectedDateTime,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
      );

      Navigator.of(context).pop(vital);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}