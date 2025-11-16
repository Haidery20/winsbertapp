import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/medications_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/customers_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/pharmaserve_splash_screen.dart';
import 'widgets/pharmaserve_logo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MedTrackApp());
}

class MedTrackApp extends StatelessWidget {
  const MedTrackApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PharmaServe',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF3282B8),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: const Color(0xFF3282B8),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const PharmaServeSplashScreen(),
      routes: {
        '/': (context) => const HomeScreen(),
        '/vitals': (context) => const VitalsScreen(),
        '/medications': (context) => const MedicationsScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
        '/reminders': (context) => const RemindersScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/customers': (context) => const CustomersScreen(),
      },
    );
  }
}