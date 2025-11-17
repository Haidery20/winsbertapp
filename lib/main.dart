import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/vitals_screen.dart';
import 'screens/medications_screen.dart';
import 'screens/appointments_screen.dart';
import 'screens/reminders_screen.dart';
import 'screens/inventory_screen.dart';
import 'screens/customers_screen.dart';
import 'screens/pharmaserve_splash_screen.dart';
import 'screens/settings_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WinsbertApp());
}

class WinsbertApp extends StatelessWidget {
  const WinsbertApp({super.key});

  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Winsbert',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B6CB0),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          centerTitle: false,
        ),
        cardTheme: const CardThemeData(
          elevation: 1,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          filled: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          height: 64,
          indicatorShape: StadiumBorder(),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B6CB0),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          elevation: 1,
          centerTitle: false,
        ),
        cardTheme: const CardThemeData(
          elevation: 1,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          filled: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
        navigationBarTheme: const NavigationBarThemeData(
          height: 64,
          indicatorShape: StadiumBorder(),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w700),
          headlineMedium: TextStyle(fontWeight: FontWeight.w700),
          headlineSmall: TextStyle(fontWeight: FontWeight.w600),
          titleMedium: TextStyle(fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
        ),
      ),
      home: const PharmaServeSplashScreen(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/vitals': (context) => const VitalsScreen(),
        '/medications': (context) => const MedicationsScreen(),
        '/appointments': (context) => const AppointmentsScreen(),
        '/reminders': (context) => const RemindersScreen(),
        '/inventory': (context) => const InventoryScreen(),
        '/customers': (context) => const CustomersScreen(),
        '/settings': (context) => const SettingsScreen(),
      },
    );
  }
}