import 'package:flutter/material.dart';
import '../widgets/navigation_drawer.dart';
import '../widgets/pharmaserve_logo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            PharmaServeLogo(
              size: 36,
              showText: false,
              customColor: Theme.of(context).colorScheme.onPrimary,
              useCustomImage: true,
            ),
            const SizedBox(width: 10),
            Text(
              'Winsbert',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const AppNavigationDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).colorScheme.primaryContainer,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    PharmaServeLogo(
                      size: 80,
                      showText: false,
                      useCustomImage: true,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Winsbert',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Modern, reliable pharmacy services',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onPrimaryContainer
                                      .withOpacity(0.8),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search medications, customers, appointments',
                prefixIcon: Icon(Icons.search),
              ),
              onTap: () {},
            ),
            const SizedBox(height: 16),
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickActionCard(
                  context,
                  icon: Icons.monitor_heart,
                  title: 'Vitals',
                  onTap: () => Navigator.pushNamed(context, '/vitals'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.medication,
                  title: 'Medications',
                  onTap: () => Navigator.pushNamed(context, '/medications'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.calendar_today,
                  title: 'Appointments',
                  onTap: () => Navigator.pushNamed(context, '/appointments'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.notifications,
                  title: 'Reminders',
                  onTap: () => Navigator.pushNamed(context, '/reminders'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.inventory,
                  title: 'Inventory',
                  onTap: () => Navigator.pushNamed(context, '/inventory'),
                ),
                _buildQuickActionCard(
                  context,
                  icon: Icons.people,
                  title: 'Customers',
                  onTap: () => Navigator.pushNamed(context, '/customers'),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        onDestinationSelected: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushNamed(context, '/medications');
              break;
            case 2:
              Navigator.pushNamed(context, '/appointments');
              break;
            case 3:
              Navigator.pushNamed(context, '/inventory');
              break;
          }
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.medication_outlined), selectedIcon: Icon(Icons.medication), label: 'Medications'),
          NavigationDestination(icon: Icon(Icons.calendar_today_outlined), selectedIcon: Icon(Icons.calendar_today), label: 'Appointments'),
          NavigationDestination(icon: Icon(Icons.inventory_2_outlined), selectedIcon: Icon(Icons.inventory_2), label: 'Inventory'),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: SizedBox(
            width: 140,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 26,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}