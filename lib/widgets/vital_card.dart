import 'package:flutter/material.dart';

class VitalCard extends StatelessWidget {
  final dynamic vital;
  final VoidCallback onDelete;

  const VitalCard({
    super.key,
    required this.vital,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getVitalColor(context),
          child: Icon(
            _getVitalIcon(),
            color: Colors.white,
          ),
        ),
        title: Text(
          vital.type,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${vital.value} ${vital.unit}'),
            Text(_formatDateTime(vital.timestamp)),
            if (vital.notes != null && vital.notes!.isNotEmpty)
              Text(
                vital.notes!,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline),
          onPressed: () => _showDeleteConfirmation(context),
        ),
      ),
    );
  }

  Color _getVitalColor(BuildContext context) {
    switch (vital.type) {
      case 'Blood Pressure':
        return Colors.red;
      case 'Heart Rate':
        return Colors.pink;
      case 'Temperature':
        return Colors.orange;
      case 'Blood Sugar':
        return Colors.purple;
      case 'Weight':
        return Colors.brown;
      case 'Height':
        return Colors.blue;
      case 'Oxygen Saturation':
        return Colors.cyan;
      case 'Respiratory Rate':
        return Colors.teal;
      default:
        return Theme.of(context).colorScheme.primary;
    }
  }

  IconData _getVitalIcon() {
    switch (vital.type) {
      case 'Blood Pressure':
        return Icons.monitor_heart;
      case 'Heart Rate':
        return Icons.favorite;
      case 'Temperature':
        return Icons.thermostat;
      case 'Blood Sugar':
        return Icons.water_drop;
      case 'Weight':
        return Icons.scale;
      case 'Height':
        return Icons.height;
      case 'Oxygen Saturation':
        return Icons.air;
      case 'Respiratory Rate':
        return Icons.air;
      default:
        return Icons.medical_services;
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      return 'Today at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Vital Reading'),
        content: Text('Are you sure you want to delete this ${vital.type} reading?'),
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