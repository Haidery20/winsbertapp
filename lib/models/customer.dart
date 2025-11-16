class Customer {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String address;
  final DateTime dateOfBirth;
  final String? emergencyContactName;
  final String? emergencyContactPhone;
  final String? insuranceProvider;
  final String? insuranceNumber;
  final String? allergies;
  final String? medicalConditions;
  final DateTime registrationDate;
  final bool isActive;

  Customer({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.address,
    required this.dateOfBirth,
    this.emergencyContactName,
    this.emergencyContactPhone,
    this.insuranceProvider,
    this.insuranceNumber,
    this.allergies,
    this.medicalConditions,
    DateTime? registrationDate,
    this.isActive = true,
  }) : registrationDate = registrationDate ?? DateTime.now();

  String get fullName => '$firstName $lastName';
  int get age => DateTime.now().year - dateOfBirth.year;
  
  String get formattedPhone {
    // Format phone number as (XXX) XXX-XXXX
    if (phone.length == 10) {
      return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
    }
    return phone;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'address': address,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'emergencyContactName': emergencyContactName,
      'emergencyContactPhone': emergencyContactPhone,
      'insuranceProvider': insuranceProvider,
      'insuranceNumber': insuranceNumber,
      'allergies': allergies,
      'medicalConditions': medicalConditions,
      'registrationDate': registrationDate.toIso8601String(),
      'isActive': isActive ? 1 : 0,
    };
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      email: map['email'],
      phone: map['phone'],
      address: map['address'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      emergencyContactName: map['emergencyContactName'],
      emergencyContactPhone: map['emergencyContactPhone'],
      insuranceProvider: map['insuranceProvider'],
      insuranceNumber: map['insuranceNumber'],
      allergies: map['allergies'],
      medicalConditions: map['medicalConditions'],
      registrationDate: DateTime.parse(map['registrationDate']),
      isActive: map['isActive'] == 1,
    );
  }

  Customer copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? address,
    DateTime? dateOfBirth,
    String? emergencyContactName,
    String? emergencyContactPhone,
    String? insuranceProvider,
    String? insuranceNumber,
    String? allergies,
    String? medicalConditions,
    DateTime? registrationDate,
    bool? isActive,
  }) {
    return Customer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      emergencyContactName: emergencyContactName ?? this.emergencyContactName,
      emergencyContactPhone: emergencyContactPhone ?? this.emergencyContactPhone,
      insuranceProvider: insuranceProvider ?? this.insuranceProvider,
      insuranceNumber: insuranceNumber ?? this.insuranceNumber,
      allergies: allergies ?? this.allergies,
      medicalConditions: medicalConditions ?? this.medicalConditions,
      registrationDate: registrationDate ?? this.registrationDate,
      isActive: isActive ?? this.isActive,
    );
  }
}