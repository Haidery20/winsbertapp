class Medication {
  final int? id;
  final String name;
  final String dosage;
  final String frequency;
  final String? instructions;
  final DateTime startDate;
  final DateTime? endDate;
  final bool isActive;
  final bool isTaken;
  final DateTime? lastTaken;
  final String? prescribedBy;
  final String? pharmacy;

  Medication({
    this.id,
    required this.name,
    required this.dosage,
    required this.frequency,
    this.instructions,
    required this.startDate,
    this.endDate,
    this.isActive = true,
    this.isTaken = false,
    this.lastTaken,
    this.prescribedBy,
    this.pharmacy,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'frequency': frequency,
      'instructions': instructions,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
      'isActive': isActive ? 1 : 0,
      'isTaken': isTaken ? 1 : 0,
      'lastTaken': lastTaken?.toIso8601String(),
      'prescribedBy': prescribedBy,
      'pharmacy': pharmacy,
    };
  }

  factory Medication.fromMap(Map<String, dynamic> map) {
    return Medication(
      id: map['id'],
      name: map['name'],
      dosage: map['dosage'],
      frequency: map['frequency'],
      instructions: map['instructions'],
      startDate: DateTime.parse(map['startDate']),
      endDate: map['endDate'] != null ? DateTime.parse(map['endDate']) : null,
      isActive: map['isActive'] == 1,
      isTaken: map['isTaken'] == 1,
      lastTaken: map['lastTaken'] != null ? DateTime.parse(map['lastTaken']) : null,
      prescribedBy: map['prescribedBy'],
      pharmacy: map['pharmacy'],
    );
  }

  Medication copyWith({
    int? id,
    String? name,
    String? dosage,
    String? frequency,
    String? instructions,
    DateTime? startDate,
    DateTime? endDate,
    bool? isActive,
    bool? isTaken,
    DateTime? lastTaken,
    String? prescribedBy,
    String? pharmacy,
  }) {
    return Medication(
      id: id ?? this.id,
      name: name ?? this.name,
      dosage: dosage ?? this.dosage,
      frequency: frequency ?? this.frequency,
      instructions: instructions ?? this.instructions,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      isActive: isActive ?? this.isActive,
      isTaken: isTaken ?? this.isTaken,
      lastTaken: lastTaken ?? this.lastTaken,
      prescribedBy: prescribedBy ?? this.prescribedBy,
      pharmacy: pharmacy ?? this.pharmacy,
    );
  }

  static List<String> get frequencies => [
        'Once daily',
        'Twice daily',
        'Three times daily',
        'Four times daily',
        'As needed',
        'Every 4 hours',
        'Every 6 hours',
        'Every 8 hours',
        'Every 12 hours',
        'Weekly',
        'Monthly',
      ];
}