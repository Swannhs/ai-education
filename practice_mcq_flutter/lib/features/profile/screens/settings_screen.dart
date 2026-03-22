import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _darkMode = false;
  bool _pushNotifications = true;
  bool _emailAlerts = false;
  bool _wifiOnly = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(child: Text('PrepBD', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold))),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildProfileRow(),
            const SizedBox(height: 32),
            _buildSectionHeader('APPLICATION'),
            _buildSettingsContainer([
              _buildSwitchTile(Icons.dark_mode_outlined, 'Dark mode', _darkMode, (v) => setState(() => _darkMode = v)),
              _buildNavigationTile(Icons.language, 'Language', 'English (US)'),
              _buildSwitchTile(Icons.notifications_none, 'Push notifications', _pushNotifications, (v) => setState(() => _pushNotifications = v)),
              _buildSwitchTile(Icons.mail_outline, 'Email alerts', _emailAlerts, (v) => setState(() => _emailAlerts = v)),
            ]),
            const SizedBox(height: 32),
            _buildSectionHeader('STORAGE'),
            _buildSettingsContainer([
              _buildSwitchTile(Icons.wifi, 'Download over Wi-Fi only', _wifiOnly, (v) => setState(() => _wifiOnly = v)),
              _buildActionTile(Icons.delete_outline, 'Clear cache', '42.5 MB'),
            ]),
            const SizedBox(height: 32),
            _buildSectionHeader('ACCOUNT'),
            _buildSettingsContainer([
              _buildNavigationTile(Icons.person_outline, 'Edit profile', ''),
              _buildNavigationTile(Icons.lock_outline, 'Change password', ''),
              _buildNavigationTile(Icons.privacy_tip_outlined, 'Privacy policy', ''),
              _buildActionTile(Icons.logout, 'Logout', '', isDestructive: true),
            ]),
            const SizedBox(height: 40),
            const Text('JOB PREP BD - VERSION 2.4.1 (STABLE)', style: TextStyle(color: AppColors.textSecondary, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 4),
    );
  }

  Widget _buildProfileRow() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(padding: const EdgeInsets.all(2), decoration: const BoxDecoration(color: Color(0xFFFFCCBC), shape: BoxShape.circle), child: const CircleAvatar(radius: 28, backgroundColor: Colors.white, child: Icon(Icons.person, color: Colors.orange))),
              Container(padding: const EdgeInsets.all(4), decoration: BoxDecoration(color: const Color(0xFF00B050), shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)), child: const Icon(Icons.edit, color: Colors.white, size: 10)),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Tanvir Ahmed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('tanvir.ahmed@example.bd', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(4)),
                  child: const Text('Pro Member', style: TextStyle(color: Color(0xFF00695C), fontSize: 10, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.0)),
      ),
    );
  }

  Widget _buildSettingsContainer(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(children: children),
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: const Color(0xFF0D47A1), size: 20)),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: Switch(value: value, onChanged: onChanged, activeColor: const Color(0xFF00B050)),
    );
  }

  Widget _buildNavigationTile(IconData icon, String title, String trailingText) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: const Color(0xFF0D47A1), size: 20)),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText.isNotEmpty) Text(trailingText, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String trailingText, {bool isDestructive = false}) {
    return ListTile(
      leading: Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: isDestructive ? Colors.red.withOpacity(0.1) : const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: isDestructive ? Colors.red : const Color(0xFF0D47A1), size: 20)),
      title: Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: isDestructive ? Colors.red : Colors.black)),
      trailing: trailingText.isNotEmpty ? Text(trailingText, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)) : null,
    );
  }
}
