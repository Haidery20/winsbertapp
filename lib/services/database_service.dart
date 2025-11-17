import '../models/medication.dart';
import '../models/reminder.dart';

class InMemoryDatabase {
  static final InMemoryDatabase _instance = InMemoryDatabase._internal();
  factory InMemoryDatabase() => _instance;
  
  InMemoryDatabase._internal() {
    // Initialize with sample data
    _initializeSampleData();
  }

  final List<dynamic> _vitals = [];
  final List<dynamic> _medications = [];
  final List<dynamic> _appointments = [];
  final List<dynamic> _reminders = [];
  // Staff management
  final List<StaffMember> _staffActive = [];
  final List<StaffMember> _staffPending = [];
  UserAccount? _currentUser;

  void _initializeSampleData() {
    // Add sample medications
    final sampleMedications = [
      Medication(
        id: 1,
        name: 'Lisinopril',
        dosage: '10mg',
        frequency: 'Once Daily',
        startDate: DateTime.now(),
        prescribedBy: 'Dr. Smith',
        pharmacy: 'CVS Pharmacy',
      ),
      Medication(
        id: 2,
        name: 'Metformin',
        dosage: '500mg',
        frequency: 'Twice Daily',
        startDate: DateTime.now(),
        prescribedBy: 'Dr. Johnson',
        pharmacy: 'Walgreens',
      ),
    ];
    
    _medications.addAll(sampleMedications);

    // Add sample reminders
    final now = DateTime.now();
    final sampleReminders = [
      Reminder(
        id: 1,
        medicationId: 1,
        medicationName: 'Lisinopril',
        scheduledTime: DateTime(now.year, now.month, now.day, 9, 0),
        dosage: '10mg',
        isTaken: false,
      ),
      Reminder(
        id: 2,
        medicationId: 2,
        medicationName: 'Metformin',
        scheduledTime: DateTime(now.year, now.month, now.day, 8, 0),
        dosage: '500mg',
        isTaken: false,
      ),
      Reminder(
        id: 3,
        medicationId: 2,
        medicationName: 'Metformin',
        scheduledTime: DateTime(now.year, now.month, now.day, 20, 0),
        dosage: '500mg',
        isTaken: false,
      ),
    ];
    
    _reminders.addAll(sampleReminders);

    // Seed staff
    _staffActive.addAll([
      StaffMember(id: 1, name: 'Admin User', email: 'admin@winsbert.com', role: StaffRole.manager, status: StaffStatus.active),
      StaffMember(id: 2, name: 'Pharmacist Jane', email: 'jane@winsbert.com', role: StaffRole.pharmacist, status: StaffStatus.active),
    ]);
    _staffPending.addAll([
      StaffMember(id: 3, name: 'Tech John', email: 'john@winsbert.com', role: StaffRole.technician, status: StaffStatus.pending),
    ]);
  }

  // Vital methods
  Future<List<dynamic>> getVitals() async => _vitals;
  
  Future<List<dynamic>> getVitalsByType(String type) async {
    return _vitals.where((vital) => vital.type == type).toList();
  }
  
  Future<dynamic> insertVital(dynamic vital) async {
    final newVital = vital.copyWith(id: _vitals.length + 1);
    _vitals.add(newVital);
    return newVital;
  }
  
  Future<int> deleteVital(int id) async {
    final initialLength = _vitals.length;
    _vitals.removeWhere((vital) => vital.id == id);
    return initialLength - _vitals.length;
  }

  // Medication methods
  Future<List<dynamic>> getMedications() async => _medications;
  
  Future<List<dynamic>> getActiveMedications() async {
    return _medications.where((med) => med.isActive == true).toList();
  }
  
  Future<dynamic> insertMedication(dynamic medication) async {
    final newMed = medication.copyWith(id: _medications.length + 1);
    _medications.add(newMed);
    return newMed;
  }
  
  Future<int> updateMedication(dynamic medication) async {
    final index = _medications.indexWhere((med) => med.id == medication.id);
    if (index != -1) {
      _medications[index] = medication;
      return 1;
    }
    return 0;
  }
  
  Future<int> deleteMedication(int id) async {
    final initialLength = _medications.length;
    _medications.removeWhere((med) => med.id == id);
    return initialLength - _medications.length;
  }

  // Appointment methods
  Future<List<dynamic>> getAppointments() async => _appointments;
  
  Future<List<dynamic>> getUpcomingAppointments() async {
    final now = DateTime.now();
    return _appointments.where((apt) => 
      apt.dateTime.isAfter(now) && apt.isCompleted == false
    ).toList();
  }
  
  Future<List<dynamic>> getPastAppointments() async {
    final now = DateTime.now();
    return _appointments.where((apt) => 
      apt.dateTime.isBefore(now)
    ).toList();
  }
  
  Future<dynamic> insertAppointment(dynamic appointment) async {
    final newApt = appointment.copyWith(id: _appointments.length + 1);
    _appointments.add(newApt);
    return newApt;
  }
  
  Future<int> updateAppointment(dynamic appointment) async {
    final index = _appointments.indexWhere((apt) => apt.id == appointment.id);
    if (index != -1) {
      _appointments[index] = appointment;
      return 1;
    }
    return 0;
  }
  
  Future<int> deleteAppointment(int id) async {
    final initialLength = _appointments.length;
    _appointments.removeWhere((apt) => apt.id == id);
    return initialLength - _appointments.length;
  }

  // Reminder methods
  Future<List<dynamic>> getReminders() async => _reminders;
  
  Future<List<dynamic>> getUpcomingReminders() async {
    final now = DateTime.now();
    return _reminders.where((reminder) => 
      reminder.scheduledTime.isAfter(now) && 
      reminder.isActive == true && 
      reminder.isTaken == false
    ).toList();
  }
  
  Future<List<dynamic>> getTodayReminders() async {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    
    return _reminders.where((reminder) => 
      reminder.scheduledTime.isAfter(startOfDay) && 
      reminder.scheduledTime.isBefore(endOfDay) && 
      reminder.isActive == true
    ).toList();
  }
  
  Future<dynamic> insertReminder(dynamic reminder) async {
    final newReminder = reminder.copyWith(id: _reminders.length + 1);
    _reminders.add(newReminder);
    return newReminder;
  }
  
  Future<int> updateReminder(dynamic reminder) async {
    final index = _reminders.indexWhere((rem) => rem.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
      return 1;
    }
    return 0;
  }
  
  Future<int> deleteReminder(int id) async {
    final initialLength = _reminders.length;
    _reminders.removeWhere((reminder) => reminder.id == id);
    return initialLength - _reminders.length;
  }
  
  // Generate reminders for a medication based on frequency
  Future<List<dynamic>> generateMedicationReminders(dynamic medication) async {
    final reminders = <dynamic>[];
    final now = DateTime.now();
    final startDate = medication.startDate;
    final endDate = medication.endDate ?? now.add(const Duration(days: 30));
    
    // Generate reminders based on frequency
    DateTime currentDate = startDate;
    
    while (currentDate.isBefore(endDate)) {
      DateTime reminderTime;
      
      // Set reminder time based on frequency
      switch (medication.frequency) {
        case 'Once Daily':
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 9, 0);
          currentDate = currentDate.add(const Duration(days: 1));
          break;
        case 'Twice Daily':
          // Morning reminder
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 9, 0);
          reminders.add(await insertReminder(
            Reminder(
              medicationId: medication.id,
              medicationName: medication.name,
              scheduledTime: reminderTime,
              dosage: medication.dosage,
            )
          ));
          // Evening reminder
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 21, 0);
          currentDate = currentDate.add(const Duration(days: 1));
          break;
        case 'Three Times Daily':
          // Morning reminder
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 8, 0);
          reminders.add(await insertReminder(
            Reminder(
              medicationId: medication.id,
              medicationName: medication.name,
              scheduledTime: reminderTime,
              dosage: medication.dosage,
            )
          ));
          // Afternoon reminder
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 14, 0);
          reminders.add(await insertReminder(
            Reminder(
              medicationId: medication.id,
              medicationName: medication.name,
              scheduledTime: reminderTime,
              dosage: medication.dosage,
            )
          ));
          // Evening reminder
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 20, 0);
          currentDate = currentDate.add(const Duration(days: 1));
          break;
        case 'As Needed':
          // Skip as-needed medications for automatic reminders
          currentDate = endDate;
          continue;
        default:
          reminderTime = DateTime(currentDate.year, currentDate.month, currentDate.day, 9, 0);
          currentDate = currentDate.add(const Duration(days: 1));
      }
      
      if (currentDate.isBefore(endDate)) {
        reminders.add(await insertReminder(
          Reminder(
            medicationId: medication.id,
            medicationName: medication.name,
            scheduledTime: reminderTime,
            dosage: medication.dosage,
          )
        ));
      }
    }
    
    return reminders;
  }

  // Auth
  final List<UserAccount> _users = [
    UserAccount(email: 'admin@winsbert.com', password: 'admin123', role: StaffRole.manager),
    UserAccount(email: 'jane@winsbert.com', password: 'staff123', role: StaffRole.pharmacist),
  ];

  bool get isAuthenticated => _currentUser != null;
  bool get isAdmin => _currentUser?.role == StaffRole.manager;
  UserAccount? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    final user = _users.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase() && u.password == password,
      orElse: () => UserAccount.empty,
    );
    if (user == UserAccount.empty) {
      return false;
    }
    _currentUser = user;
    return true;
  }

  Future<void> logout() async {
    _currentUser = null;
  }

  // Staff management methods

  Future<List<StaffMember>> getActiveStaff() async => List.unmodifiable(_staffActive);
  Future<List<StaffMember>> getPendingStaff() async => List.unmodifiable(_staffPending);

  Future<StaffMember> addPendingStaff({required String name, required String email, StaffRole role = StaffRole.clerk}) async {
    final id = (_staffActive.length + _staffPending.length) + 1;
    final member = StaffMember(id: id, name: name, email: email, role: role, status: StaffStatus.pending);
    _staffPending.add(member);
    return member;
  }

  Future<int> approveStaff(int id, {StaffRole? role}) async {
    final index = _staffPending.indexWhere((s) => s.id == id);
    if (index != -1) {
      final approved = _staffPending.removeAt(index);
      final updated = approved.copyWith(status: StaffStatus.active, role: role ?? approved.role);
      _staffActive.add(updated);
      return 1;
    }
    return 0;
  }

  Future<int> rejectStaff(int id) async {
    final initial = _staffPending.length;
    _staffPending.removeWhere((s) => s.id == id);
    return initial - _staffPending.length;
  }

  Future<int> updateStaffRole(int id, StaffRole role) async {
    final index = _staffActive.indexWhere((s) => s.id == id);
    if (index != -1) {
      _staffActive[index] = _staffActive[index].copyWith(role: role);
      return 1;
    }
    return 0;
  }

  Future<int> removeStaff(int id) async {
    final initial = _staffActive.length;
    _staffActive.removeWhere((s) => s.id == id);
    return initial - _staffActive.length;
  }
}

enum StaffRole { manager, pharmacist, technician, clerk }

enum StaffStatus { pending, active }

class StaffMember {
  final int id;
  final String name;
  final String email;
  final StaffRole role;
  final StaffStatus status;

  StaffMember({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
  });

  StaffMember copyWith({
    int? id,
    String? name,
    String? email,
    StaffRole? role,
    StaffStatus? status,
  }) {
    return StaffMember(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      status: status ?? this.status,
    );
  }
}

class UserAccount {
  final String email;
  final String password;
  final StaffRole role;

  const UserAccount({required this.email, required this.password, required this.role});

  static const empty = UserAccount(email: '', password: '', role: StaffRole.clerk);
}