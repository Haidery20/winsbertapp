class Vital {
  final int? id;
  final String type;
  final String value;
  final String unit;
  final DateTime timestamp;
  final String? notes;

  Vital({
    this.id,
    required this.type,
    required this.value,
    required this.unit,
    required this.timestamp,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'value': value,
      'unit': unit,
      'timestamp': timestamp.toIso8601String(),
      'notes': notes,
    };
  }

  factory Vital.fromMap(Map<String, dynamic> map) {
    return Vital(
      id: map['id'],
      type: map['type'],
      value: map['value'],
      unit: map['unit'],
      timestamp: DateTime.parse(map['timestamp']),
      notes: map['notes'],
    );
  }

  Vital copyWith({
    int? id,
    String? type,
    String? value,
    String? unit,
    DateTime? timestamp,
    String? notes,
  }) {
    return Vital(
      id: id ?? this.id,
      type: type ?? this.type,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      timestamp: timestamp ?? this.timestamp,
      notes: notes ?? this.notes,
    );
  }

  static List<String> get vitalTypes => [
        'Blood Pressure',
        'Heart Rate',
        'Temperature',
        'Blood Sugar',
        'Weight',
        'Height',
        'Oxygen Saturation',
        'Respiratory Rate',
      ];

  static Map<String, String> get vitalUnits => {
        'Blood Pressure': 'mmHg',
        'Heart Rate': 'bpm',
        'Temperature': '°F',
        'Blood Sugar': 'mg/dL',
        'Weight': 'lbs',
        'Height': 'inches',
        'Oxygen Saturation': '%',
        'Respiratory Rate': 'breaths/min',
      };
}