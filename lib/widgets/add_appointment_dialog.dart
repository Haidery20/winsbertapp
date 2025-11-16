import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AddAppointmentDialog extends StatefulWidget {
  const AddAppointmentDialog({super.key});

  @override
  State<AddAppointmentDialog> createState() => _AddAppointmentDialogState();
}

class _AddAppointmentDialogState extends State<AddAppointmentDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _doctorController = TextEditingController();
  final _locationController = TextEditingController();
  final _notesController = TextEditingController();
  
  DateTime _selectedDateTime = DateTime.now();
  DateTime? _reminderTime;

  @override
  void dispose() {
    _titleController.dispose();
    _doctorController.dispose();
    _locationController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Schedule Appointment'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Appointment Title',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Annual Checkup, Dental Cleaning',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter appointment title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _doctorController,
                decoration: const InputDecoration(
                  labelText: 'Doctor Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter doctor name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Clinic name, address',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter location';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // DropdownButtonFormField<String>(
              //   value: _selectedType,
              //   decoration: const InputDecoration(
              //     labelText: 'Appointment Type (Optional)',
              //     border: OutlineInputBorder(),
              //   ),
              //   items: [],
              //   onChanged: (value) {
              //     setState(() {
              //       _selectedType = value;
              //     });
              //   },
              // ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Date & Time'),
                subtitle: Text(_formatDateTime(_selectedDateTime)),
                trailing: const Icon(Icons.calendar_today),
                onTap: _selectDateTime,
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text('Reminder (Optional)'),
                subtitle: Text(_reminderTime == null ? 'No reminder' : _formatDateTime(_reminderTime!)),
                trailing: const Icon(Icons.notifications),
                onTap: _selectReminderTime,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(
                  labelText: 'Notes (Optional)',
                  border: OutlineInputBorder(),
                  hintText: 'Any additional notes...',
                ),
                maxLines: 3,
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
          child: const Text('Schedule'),
        ),
      ],
    );
  }

  Future<void> _selectDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
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

  Future<void> _selectReminderTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _reminderTime ?? _selectedDateTime.subtract(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: _selectedDateTime,
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_reminderTime ?? _selectedDateTime.subtract(const Duration(hours: 1))),
      );

      if (time != null) {
        setState(() {
          _reminderTime = DateTime(
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
      final appointment = Appointment(
        title: _titleController.text,
        doctor: _doctorController.text,
        location: _locationController.text,
        dateTime: _selectedDateTime,
        notes: _notesController.text.isEmpty ? null : _notesController.text,
        type: null,
        isCompleted: false,
        reminderTime: _reminderTime,
      );

      Navigator.of(context).pop(appointment);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}