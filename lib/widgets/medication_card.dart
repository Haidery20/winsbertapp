import 'package:flutter/material.dart';
import '../models/medication.dart';

class MedicationCard extends StatelessWidget {
  final Medication medication;
  final VoidCallback onDelete;
  final VoidCallback onToggleTaken;

  const MedicationCard({
    super.key,
    required this.medication,
    required this.onDelete,
    required this.onToggleTaken,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: medication.isTaken 
            ? Colors.green 
            : Theme.of(context).colorScheme.primary,
          child: Icon(
            medication.isTaken ? Icons.check : Icons.medication,
            color: Colors.white,
          ),
        ),
        title: Text(
          medication.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${medication.dosage} - ${medication.frequency}'),
            if (medication.instructions != null && medication.instructions!.isNotEmpty)
              Text(
                medication.instructions!,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            if (medication.lastTaken != null)
              Text(
                'Last taken: ${_formatDateTime(medication.lastTaken!)}',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                medication.isTaken ? Icons.undo : Icons.check_circle,
                color: medication.isTaken ? Colors.orange : Colors.green,
              ),
              onPressed: onToggleTaken,
              tooltip: medication.isTaken ? 'Mark as not taken' : 'Mark as taken',
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showDeleteConfirmation(context),
            ),
          ],
        ),
        onTap: () => _showMedicationDetails(context),
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        return '${difference.inMinutes} minutes ago';
      }
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    }
  }

  void _showMedicationDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(medication.name),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Dosage', medication.dosage),
              _buildDetailRow('Frequency', medication.frequency),
              if (medication.instructions != null && medication.instructions!.isNotEmpty)
                _buildDetailRow('Instructions', medication.instructions!),
              _buildDetailRow('Start Date', _formatDate(medication.startDate)),
              if (medication.endDate != null)
                _buildDetailRow('End Date', _formatDate(medication.endDate!)),
              if (medication.prescribedBy != null)
                _buildDetailRow('Prescribed By', medication.prescribedBy!),
              if (medication.pharmacy != null)
                _buildDetailRow('Pharmacy', medication.pharmacy!),
              _buildDetailRow('Status', medication.isActive ? 'Active' : 'Inactive'),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Medication'),
        content: Text('Are you sure you want to delete ${medication.name}?'),
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