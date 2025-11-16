import 'package:flutter/material.dart';

class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.medical_services,
                size: 48,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'MedTrack',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Your Health Companion',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer.withOpacity(0.8),
                    ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: const Text('Home'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.monitor_heart),
          title: const Text('Vitals'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/vitals');
          },
        ),
        ListTile(
          leading: const Icon(Icons.medication),
          title: const Text('Medications'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/medications');
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Appointments'),
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, '/appointments');
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('Settings'),
          onTap: () {
            Navigator.pop(context);
            // TODO: Navigate to settings screen
          },
        ),
        ListTile(
          leading: const Icon(Icons.info),
          title: const Text('About'),
          onTap: () {
            Navigator.pop(context);
            showAboutDialog(
              context: context,
              applicationName: 'MedTrack',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2024 MedTrack',
            );
          },
        ),
      ],
    );
  }
}