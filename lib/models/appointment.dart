class Appointment {
  final int? id;
  final String title;
  final String doctor;
  final String location;
  final DateTime dateTime;
  final String? notes;
  final String? type;
  final bool isCompleted;
  final DateTime? reminderTime;
  final DateTime createdAt;

  Appointment({
    this.id,
    required this.title,
    required this.doctor,
    required this.location,
    required this.dateTime,
    this.notes,
    this.type,
    this.isCompleted = false,
    this.reminderTime,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'doctor': doctor,
      'location': location,
      'dateTime': dateTime.toIso8601String(),
      'notes': notes,
      'type': type,
      'isCompleted': isCompleted ? 1 : 0,
      'reminderTime': reminderTime?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      doctor: map['doctor'],
      location: map['location'],
      dateTime: DateTime.parse(map['dateTime']),
      notes: map['notes'],
      type: map['type'],
      isCompleted: map['isCompleted'] == 1,
      reminderTime: map['reminderTime'] != null ? DateTime.parse(map['reminderTime']) : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Appointment copyWith({
    int? id,
    String? title,
    String? doctor,
    String? location,
    DateTime? dateTime,
    String? notes,
    String? type,
    bool? isCompleted,
    DateTime? reminderTime,
    DateTime? createdAt,
  }) {
    return Appointment(
      id: id ?? this.id,
      title: title ?? this.title,
      doctor: doctor ?? this.doctor,
      location: location ?? this.location,
      dateTime: dateTime ?? this.dateTime,
      notes: notes ?? this.notes,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      reminderTime: reminderTime ?? this.reminderTime,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static List<String> get appointmentTypes => [
        'General Checkup',
        'Dental',
        'Eye Exam',
        'Blood Test',
        'X-Ray',
        'Ultrasound',
        'MRI',
        'CT Scan',
        'Surgery',
        'Follow-up',
        'Specialist',
        'Vaccination',
        'Physical Therapy',
        'Mental Health',
      ];

  bool get isUpcoming => dateTime.isAfter(DateTime.now());
  bool get isToday => 
    dateTime.year == DateTime.now().year &&
    dateTime.month == DateTime.now().month &&
    dateTime.day == DateTime.now().day;
  bool get isPast => dateTime.isBefore(DateTime.now());
}