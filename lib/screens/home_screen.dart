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
              size: 40,
              showText: false,
              customColor: Theme.of(context).colorScheme.onPrimary,
              useCustomImage: true,
            ),
            const SizedBox(width: 12),
            Text(
              'PharmaServe',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        shadowColor: Theme.of(context).colorScheme.primary.withOpacity(0.3),
      ),
      drawer: const AppNavigationDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Enhanced logo with glow effect using your custom PNG
            PharmaServeLogo(
              size: 160,
              showText: true,
              showGlow: true,
              useCustomImage: true,
            ),
            const SizedBox(height: 40),
            Text(
              'Welcome to PharmaServe',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your trusted pharmaceutical partner',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
    );
  }

  Widget _buildQuickActionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.9),
            Theme.of(context).colorScheme.primary.withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 36,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
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