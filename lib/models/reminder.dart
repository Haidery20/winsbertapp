
class Reminder {
  final int? id;
  final int medicationId;
  final String medicationName;
  final DateTime scheduledTime;
  final String dosage;
  final bool isTaken;
  final DateTime? takenTime;
  final String? notes;
  final bool isActive;

  Reminder({
    this.id,
    required this.medicationId,
    required this.medicationName,
    required this.scheduledTime,
    required this.dosage,
    this.isTaken = false,
    this.takenTime,
    this.notes,
    this.isActive = true,
  });

  Reminder copyWith({
    int? id,
    int? medicationId,
    String? medicationName,
    DateTime? scheduledTime,
    String? dosage,
    bool? isTaken,
    DateTime? takenTime,
    String? notes,
    bool? isActive,
  }) {
    return Reminder(
      id: id ?? this.id,
      medicationId: medicationId ?? this.medicationId,
      medicationName: medicationName ?? this.medicationName,
      scheduledTime: scheduledTime ?? this.scheduledTime,
      dosage: dosage ?? this.dosage,
      isTaken: isTaken ?? this.isTaken,
      takenTime: takenTime ?? this.takenTime,
      notes: notes ?? this.notes,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'medicationId': medicationId,
      'medicationName': medicationName,
      'scheduledTime': scheduledTime.toIso8601String(),
      'dosage': dosage,
      'isTaken': isTaken ? 1 : 0,
      'takenTime': takenTime?.toIso8601String(),
      'notes': notes,
      'isActive': isActive ? 1 : 0,
    };
  }

  factory Reminder.fromMap(Map<String, dynamic> map) {
    return Reminder(
      id: map['id'],
      medicationId: map['medicationId'],
      medicationName: map['medicationName'],
      scheduledTime: DateTime.parse(map['scheduledTime']),
      dosage: map['dosage'],
      isTaken: map['isTaken'] == 1,
      takenTime: map['takenTime'] != null ? DateTime.parse(map['takenTime']) : null,
      notes: map['notes'],
      isActive: map['isActive'] == 1,
    );
  }

  @override
  String toString() {
    return 'Reminder(id: $id, medicationName: $medicationName, scheduledTime: $scheduledTime, dosage: $dosage, isTaken: $isTaken)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Reminder &&
      other.id == id &&
      other.medicationId == medicationId &&
      other.medicationName == medicationName &&
      other.scheduledTime == scheduledTime &&
      other.dosage == dosage &&
      other.isTaken == isTaken &&
      other.takenTime == takenTime &&
      other.notes == notes &&
      other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      medicationId.hashCode ^
      medicationName.hashCode ^
      scheduledTime.hashCode ^
      dosage.hashCode ^
      isTaken.hashCode ^
      takenTime.hashCode ^
      notes.hashCode ^
      isActive.hashCode;
  }
}