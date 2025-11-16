import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/medications_screen.dart';
import 'screens/appointments_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MedTrackApp());
}

class MedTrackApp extends StatelessWidget {
  const MedTrackApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedTrack',
      theme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: Colors.teal,
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const HomeScreen(),
      routes: {
        '/vitals': (context) => const VitalsScreen(),
        '/medications': (context) => const MedicationsScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
      },
    );
  }
}