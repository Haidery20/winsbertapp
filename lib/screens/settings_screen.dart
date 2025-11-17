import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoBackupEnabled = true;
  int _reminderTime = 30; // minutes before medication time
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // App Settings Section
          _buildSectionHeader('App Settings'),
          _buildSettingsCard([
            ListTile(
              leading: const Icon(Icons.notifications, color: Colors.blue),
              title: const Text('Notifications'),
              subtitle: const Text('Enable medication reminders'),
              trailing: Switch(
                value: _notificationsEnabled,
                onChanged: (value) {
                  setState(() {
                    _notificationsEnabled = value;
                  });
                },
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.brightness_6, color: Colors.orange),
              title: const Text('Dark Mode'),
              subtitle: const Text('Switch to dark theme'),
              trailing: Switch(
                value: _darkModeEnabled,
                onChanged: (value) {
                  setState(() {
                    _darkModeEnabled = value;
                  });
                  // TODO: Implement theme switching
                },
              ),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.language, color: Colors.green),
              title: const Text('Language'),
              subtitle: Text(_selectedLanguage),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showLanguageDialog,
            ),
          ]),

          const SizedBox(height: 24),

          // Medication Settings Section
          _buildSectionHeader('Medication Settings'),
          _buildSettingsCard([
            ListTile(
              leading: const Icon(Icons.alarm, color: Colors.purple),
              title: const Text('Reminder Time'),
              subtitle: Text('$_reminderTime minutes before'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showReminderTimeDialog,
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.backup, color: Colors.teal),
              title: const Text('Auto Backup'),
              subtitle: const Text('Backup data automatically'),
              trailing: Switch(
                value: _autoBackupEnabled,
                onChanged: (value) {
                  setState(() {
                    _autoBackupEnabled = value;
                  });
                },
              ),
            ),
          ]),

          const SizedBox(height: 24),

          // Pharmacy Settings Section
          _buildSectionHeader('Pharmacy Settings'),
          _buildSettingsCard([
            ListTile(
              leading: const Icon(Icons.local_pharmacy, color: Colors.red),
              title: const Text('Pharmacy Information'),
              subtitle: const Text('Store details and hours'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showPharmacyInfoDialog,
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.inventory, color: Colors.brown),
              title: const Text('Inventory Alerts'),
              subtitle: const Text('Low stock notifications'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showInventoryAlertsDialog,
            ),
          ]),

          const SizedBox(height: 24),

          // Account Settings Section
          _buildSectionHeader('Account Settings'),
          _buildSettingsCard([
            ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo),
              title: const Text('Profile'),
              subtitle: const Text('Manage your profile'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showProfileDialog,
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.lock, color: Colors.amber),
              title: const Text('Privacy & Security'),
              subtitle: const Text('Data protection settings'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showPrivacyDialog,
            ),
          ]),

          const SizedBox(height: 24),

          // About Section
          _buildSectionHeader('About'),
          _buildSettingsCard([
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.grey),
              title: const Text('About Winsbert'),
              subtitle: const Text('App version and information'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showAboutDialog,
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.grey),
              title: const Text('Help & Support'),
              subtitle: const Text('Get help and contact support'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: _showHelpDialog,
            ),
          ]),

          const SizedBox(height: 32),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
                foregroundColor: Theme.of(context).colorScheme.onError,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: _showLogoutConfirmation,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: const Text('English'),
              value: 'English',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('Spanish'),
              value: 'Spanish',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
            RadioListTile<String>(
              title: const Text('French'),
              value: 'French',
              groupValue: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showReminderTimeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reminder Time'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('How many minutes before medication time?'),
            const SizedBox(height: 16),
            Slider(
              value: _reminderTime.toDouble(),
              min: 5,
              max: 60,
              divisions: 11,
              label: '$_reminderTime minutes',
              onChanged: (value) {
                setState(() {
                  _reminderTime = value.round();
                });
              },
            ),
            Text('$_reminderTime minutes before'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPharmacyInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pharmacy Information'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Winsbert Pharmacy', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('123 Medical Street'),
            Text('Healthcare District'),
            Text('City, State 12345'),
            SizedBox(height: 16),
            Text('Hours:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text('Monday - Friday: 8:00 AM - 8:00 PM'),
            Text('Saturday: 9:00 AM - 6:00 PM'),
            Text('Sunday: 10:00 AM - 4:00 PM'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showInventoryAlertsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Inventory Alerts'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CheckboxListTile(
              title: const Text('Low Stock Alerts'),
              subtitle: const Text('Notify when stock is below 10 units'),
              value: true,
              onChanged: (value) {
                // TODO: Implement low stock alerts setting
              },
            ),
            CheckboxListTile(
              title: const Text('Expiration Alerts'),
              subtitle: const Text('Notify 30 days before expiration'),
              value: true,
              onChanged: (value) {
                // TODO: Implement expiration alerts setting
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Profile Settings'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
                prefixIcon: Icon(Icons.person),
              ),
              controller: TextEditingController(text: 'Pharmacy Manager'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email),
              ),
              controller: TextEditingController(text: 'manager@winsbert.com'),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone',
                prefixIcon: Icon(Icons.phone),
              ),
              controller: TextEditingController(text: '+1 (555) 123-4567'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Save profile changes
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showPrivacyDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Privacy & Security'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SwitchListTile(
              title: const Text('Biometric Authentication'),
              subtitle: const Text('Use fingerprint/face recognition'),
              value: false,
              onChanged: (value) {
                // TODO: Implement biometric authentication
              },
            ),
            SwitchListTile(
              title: const Text('Data Encryption'),
              subtitle: const Text('Encrypt sensitive data'),
              value: true,
              onChanged: (value) {
                // TODO: Implement data encryption setting
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.open_in_new, size: 16),
              onTap: () {
                // TODO: Open privacy policy
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog() {
    showAboutDialog(
      context: context,
      applicationName: 'Winsbert',
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2024 Winsbert. All rights reserved.',
      children: [
        const SizedBox(height: 16),
        const Text(
          'Professional pharmaceutical management system designed to help pharmacies manage inventory, prescriptions, and customer relationships efficiently.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• Medication inventory management'),
        const Text('• Prescription tracking'),
        const Text('• Customer management'),
        const Text('• Automated reminders'),
        const Text('• Refill notifications'),
      ],
    );
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help & Support'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.blue),
              title: const Text('User Guide'),
              subtitle: const Text('Learn how to use the app'),
              onTap: () {
                // TODO: Open user guide
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.green),
              title: const Text('Contact Support'),
              subtitle: const Text('support@winsbert.com'),
              onTap: () {
                // TODO: Open email client
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report, color: Colors.orange),
              title: const Text('Report a Bug'),
              subtitle: const Text('Help us improve the app'),
              onTap: () {
                // TODO: Open bug report form
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // TODO: Implement logout functionality
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}