import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/vital.dart';
import '../models/medication.dart';
import '../models/appointment.dart';

class DatabaseService {
  static final DatabaseService instance = DatabaseService._init();
  static Database? _database;

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('medtrack.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textNullableType = 'TEXT';
    const intType = 'INTEGER NOT NULL';
    const intNullableType = 'INTEGER';
    const boolType = 'INTEGER NOT NULL';

    // Create vitals table
    await db.execute('''
      CREATE TABLE vitals (
        id $idType,
        type $textType,
        value $textType,
        unit $textType,
        timestamp $textType,
        notes $textNullableType
      )
    ''');

    // Create medications table
    await db.execute('''
      CREATE TABLE medications (
        id $idType,
        name $textType,
        dosage $textType,
        frequency $textType,
        instructions $textNullableType,
        startDate $textType,
        endDate $textNullableType,
        isActive $boolType DEFAULT 1,
        isTaken $boolType DEFAULT 0,
        lastTaken $textNullableType,
        prescribedBy $textNullableType,
        pharmacy $textNullableType
      )
    ''');

    // Create appointments table
    await db.execute('''
      CREATE TABLE appointments (
        id $idType,
        title $textType,
        doctor $textType,
        location $textType,
        dateTime $textType,
        notes $textNullableType,
        type $textNullableType,
        isCompleted $boolType DEFAULT 0,
        reminderTime $textNullableType,
        createdAt $textType
      )
    ''');
  }

  // Vital methods
  Future<Vital> insertVital(Vital vital) async {
    final db = await instance.database;
    final id = await db.insert('vitals', vital.toMap());
    return vital.copyWith(id: id);
  }

  Future<List<Vital>> getVitals() async {
    final db = await instance.database;
    final result = await db.query('vitals', orderBy: 'timestamp DESC');
    return result.map((json) => Vital.fromMap(json)).toList();
  }

  Future<List<Vital>> getVitalsByType(String type) async {
    final db = await instance.database;
    final result = await db.query(
      'vitals',
      where: 'type = ?',
      whereArgs: [type],
      orderBy: 'timestamp DESC',
    );
    return result.map((json) => Vital.fromMap(json)).toList();
  }

  Future<int> deleteVital(int id) async {
    final db = await instance.database;
    return await db.delete('vitals', where: 'id = ?', whereArgs: [id]);
  }

  // Medication methods
  Future<Medication> insertMedication(Medication medication) async {
    final db = await instance.database;
    final id = await db.insert('medications', medication.toMap());
    return medication.copyWith(id: id);
  }

  Future<List<Medication>> getMedications() async {
    final db = await instance.database;
    final result = await db.query('medications', orderBy: 'name ASC');
    return result.map((json) => Medication.fromMap(json)).toList();
  }

  Future<List<Medication>> getActiveMedications() async {
    final db = await instance.database;
    final result = await db.query(
      'medications',
      where: 'isActive = ?',
      whereArgs: [1],
      orderBy: 'name ASC',
    );
    return result.map((json) => Medication.fromMap(json)).toList();
  }

  Future<int> updateMedication(Medication medication) async {
    final db = await instance.database;
    return await db.update(
      'medications',
      medication.toMap(),
      where: 'id = ?',
      whereArgs: [medication.id],
    );
  }

  Future<int> deleteMedication(int id) async {
    final db = await instance.database;
    return await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }

  // Appointment methods
  Future<Appointment> insertAppointment(Appointment appointment) async {
    final db = await instance.database;
    final id = await db.insert('appointments', appointment.toMap());
    return appointment.copyWith(id: id);
  }

  Future<List<Appointment>> getAppointments() async {
    final db = await instance.database;
    final result = await db.query('appointments', orderBy: 'dateTime ASC');
    return result.map((json) => Appointment.fromMap(json)).toList();
  }

  Future<List<Appointment>> getUpcomingAppointments() async {
    final db = await instance.database;
    final now = DateTime.now().toIso8601String();
    final result = await db.query(
      'appointments',
      where: 'dateTime >= ? AND isCompleted = ?',
      whereArgs: [now, 0],
      orderBy: 'dateTime ASC',
    );
    return result.map((json) => Appointment.fromMap(json)).toList();
  }

  Future<List<Appointment>> getPastAppointments() async {
    final db = await instance.database;
    final now = DateTime.now().toIso8601String();
    final result = await db.query(
      'appointments',
      where: 'dateTime < ?',
      whereArgs: [now],
      orderBy: 'dateTime DESC',
    );
    return result.map((json) => Appointment.fromMap(json)).toList();
  }

  Future<int> updateAppointment(Appointment appointment) async {
    final db = await instance.database;
    return await db.update(
      'appointments',
      appointment.toMap(),
      where: 'id = ?',
      whereArgs: [appointment.id],
    );
  }

  Future<int> deleteAppointment(int id) async {
    final db = await instance.database;
    return await db.delete('appointments', where: 'id = ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}