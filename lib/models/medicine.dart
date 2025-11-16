class Medicine {
  final int? id;
  final String name;
  final String genericName;
  final String manufacturer;
  final String category; // e.g., 'Pain Relief', 'Antibiotics', 'Heart Medication'
  final String strength; // e.g., '500mg', '10ml'
  final String form; // e.g., 'Tablet', 'Capsule', 'Liquid', 'Cream'
  final String ndcNumber; // National Drug Code
  final double unitPrice;
  final int stockQuantity;
  final int minimumStock;
  final DateTime expirationDate;
  final String? storageInstructions; // e.g., 'Store at room temperature'
  final String? warnings;
  final String? contraindications;
  final bool requiresPrescription;
  final bool isControlledSubstance;
  final DateTime? lastRestocked;
  final DateTime createdAt;

  Medicine({
    this.id,
    required this.name,
    required this.genericName,
    required this.manufacturer,
    required this.category,
    required this.strength,
    required this.form,
    required this.ndcNumber,
    required this.unitPrice,
    required this.stockQuantity,
    required this.minimumStock,
    required this.expirationDate,
    this.storageInstructions,
    this.warnings,
    this.contraindications,
    required this.requiresPrescription,
    required this.isControlledSubstance,
    this.lastRestocked,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  bool get isLowStock => stockQuantity <= minimumStock;
  bool get isExpired => expirationDate.isBefore(DateTime.now());
  bool get isExpiringSoon {
    final thirtyDaysFromNow = DateTime.now().add(const Duration(days: 30));
    return expirationDate.isBefore(thirtyDaysFromNow) && !isExpired;
  }
  
  String get stockStatus {
    if (isExpired) return 'Expired';
    if (isExpiringSoon) return 'Expiring Soon';
    if (isLowStock) return 'Low Stock';
    return 'In Stock';
  }

  Color get stockStatusColor {
    if (isExpired) return 'danger';
    if (isExpiringSoon) return 'warning';
    if (isLowStock) return 'caution';
    return 'success';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'genericName': genericName,
      'manufacturer': manufacturer,
      'category': category,
      'strength': strength,
      'form': form,
      'ndcNumber': ndcNumber,
      'unitPrice': unitPrice,
      'stockQuantity': stockQuantity,
      'minimumStock': minimumStock,
      'expirationDate': expirationDate.toIso8601String(),
      'storageInstructions': storageInstructions,
      'warnings': warnings,
      'contraindications': contraindications,
      'requiresPrescription': requiresPrescription ? 1 : 0,
      'isControlledSubstance': isControlledSubstance ? 1 : 0,
      'lastRestocked': lastRestocked?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Medicine.fromMap(Map<String, dynamic> map) {
    return Medicine(
      id: map['id'],
      name: map['name'],
      genericName: map['genericName'],
      manufacturer: map['manufacturer'],
      category: map['category'],
      strength: map['strength'],
      form: map['form'],
      ndcNumber: map['ndcNumber'],
      unitPrice: map['unitPrice'],
      stockQuantity: map['stockQuantity'],
      minimumStock: map['minimumStock'],
      expirationDate: DateTime.parse(map['expirationDate']),
      storageInstructions: map['storageInstructions'],
      warnings: map['warnings'],
      contraindications: map['contraindications'],
      requiresPrescription: map['requiresPrescription'] == 1,
      isControlledSubstance: map['isControlledSubstance'] == 1,
      lastRestocked: map['lastRestocked'] != null ? DateTime.parse(map['lastRestocked']) : null,
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Medicine copyWith({
    int? id,
    String? name,
    String? genericName,
    String? manufacturer,
    String? category,
    String? strength,
    String? form,
    String? ndcNumber,
    double? unitPrice,
    int? stockQuantity,
    int? minimumStock,
    DateTime? expirationDate,
    String? storageInstructions,
    String? warnings,
    String? contraindications,
    bool? requiresPrescription,
    bool? isControlledSubstance,
    DateTime? lastRestocked,
    DateTime? createdAt,
  }) {
    return Medicine(
      id: id ?? this.id,
      name: name ?? this.name,
      genericName: genericName ?? this.genericName,
      manufacturer: manufacturer ?? this.manufacturer,
      category: category ?? this.category,
      strength: strength ?? this.strength,
      form: form ?? this.form,
      ndcNumber: ndcNumber ?? this.ndcNumber,
      unitPrice: unitPrice ?? this.unitPrice,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      minimumStock: minimumStock ?? this.minimumStock,
      expirationDate: expirationDate ?? this.expirationDate,
      storageInstructions: storageInstructions ?? this.storageInstructions,
      warnings: warnings ?? this.warnings,
      contraindications: contraindications ?? this.contraindications,
      requiresPrescription: requiresPrescription ?? this.requiresPrescription,
      isControlledSubstance: isControlledSubstance ?? this.isControlledSubstance,
      lastRestocked: lastRestocked ?? this.lastRestocked,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  static List<String> get categories => [
    'Pain Relief',
    'Antibiotics',
    'Heart Medication',
    'Blood Pressure',
    'Diabetes',
    'Respiratory',
    'Digestive',
    'Vitamins & Supplements',
    'Skin Care',
    'Eye Care',
    'Mental Health',
    'Hormonal',
    'Antiviral',
    'Antifungal',
    'Antihistamine',
    'Cough & Cold',
    'First Aid',
    'Other',
  ];

  static List<String> get forms => [
    'Tablet',
    'Capsule',
    'Liquid',
    'Cream',
    'Ointment',
    'Gel',
    'Injection',
    'Inhaler',
    'Drops',
    'Patch',
    'Powder',
    'Spray',
    'Lozenge',
    'Suppository',
    'Other',
  ];
}