import 'package:flutter/material.dart';

class InMemoryDatabase {
  static final InMemoryDatabase _instance = InMemoryDatabase._internal();
  factory InMemoryDatabase() => _instance;
  InMemoryDatabase._internal();

  final List<dynamic> _vitals = [];
  final List<dynamic> _medications = [];
  final List<dynamic> _appointments = [];

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
}