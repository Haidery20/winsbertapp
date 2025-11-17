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
}