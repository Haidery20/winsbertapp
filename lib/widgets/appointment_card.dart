import 'package:flutter/material.dart';
import '../models/appointment.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onDelete;

  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(context),
          child: Icon(
            _getAppointmentIcon(),
            color: Colors.white,
          ),
        ),
        title: Text(
          appointment.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dr. ${appointment.doctor}'),
            Text(appointment.location),
            Text(_formatDateTime(appointment.dateTime)),
            if (appointment.isCompleted)
              Text(
                'Completed',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              )
            else if (appointment.isToday)
              Text(
                'Today',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                ),
              )
            else if (appointment.isUpcoming)
              Text(
                'Upcoming',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!appointment.isCompleted && appointment.isPast)
              IconButton(
                icon: const Icon(Icons.check_circle, color: Colors.green),
                onPressed: () => _markAsCompleted(context),
                tooltip: 'Mark as completed',
              ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
        onTap: () => _showAppointmentDetails(context),
      ),
    );
  }

  Color _getStatusColor(BuildContext context) {
    if (appointment.isCompleted) return Colors.green;
    if (appointment.isToday) return Colors.orange;
    if (appointment.isUpcoming) return Colors.blue;
    return Colors.grey;
  }

  IconData _getAppointmentIcon() {
    switch (appointment.type) {
      case 'Dental':
        return Icons.medical_services;
      case 'Eye Exam':
        return Icons.visibility;
      case 'Blood Test':
        return Icons.water_drop;
      case 'X-Ray':
        return Icons.broken_image;
      case 'Ultrasound':
        return Icons.waves;
      case 'MRI':
      case 'CT Scan':
        return Icons.scanner;
      case 'Surgery':
        return Icons.surgery;
      case 'Vaccination':
        return Icons.vaccines;
      case 'Physical Therapy':
        return Icons.accessibility;
      case 'Mental Health':
        return Icons.psychology;
      default:
        return Icons.person;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (appointment.isToday) {
      return 'Today at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (appointment.isTomorrow) {
      return 'Tomorrow at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${_getWeekday(dateTime.weekday)}, ${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  String _getWeekday(int weekday) {
    const weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return weekdays[weekday - 1];
  }

  String _getMonth(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return dateTime.year == tomorrow.year &&
           dateTime.month == tomorrow.month &&
           dateTime.day == tomorrow.day;
  }

  void _showAppointmentDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(appointment.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Doctor', 'Dr. ${appointment.doctor}'),
              _buildDetailRow('Location', appointment.location),
              _buildDetailRow('Date & Time', _formatFullDateTime(appointment.dateTime)),
              if (appointment.type != null)
                _buildDetailRow('Type', appointment.type!),
              if (appointment.notes != null && appointment.notes!.isNotEmpty)
                _buildDetailRow('Notes', appointment.notes!),
              _buildDetailRow('Status', appointment.isCompleted ? 'Completed' : 'Scheduled'),
              if (appointment.reminderTime != null)
                _buildDetailRow('Reminder', _formatFullDateTime(appointment.reminderTime!)),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  String _formatFullDateTime(DateTime dateTime) {
    return '${_getWeekday(dateTime.weekday)}, ${dateTime.day} ${_getMonth(dateTime.month)} ${dateTime.year} at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  void _markAsCompleted(BuildContext context) async {
    // TODO: Implement mark as completed functionality
    Navigator.of(context).pop();
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Appointment'),
        content: Text('Are you sure you want to delete "${appointment.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              onDelete();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}