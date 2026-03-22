import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildUserHeader(),
            const SizedBox(height: 24),
            _buildStatsRow(),
            const SizedBox(height: 24),
            _buildTargetCard(),
            const SizedBox(height: 32),
            _buildMenuSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildUserHeader() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundColor: AppColors.border,
              child: Icon(Icons.person, size: 60),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(color: const Color(0xFF00695C), borderRadius: BorderRadius.circular(20)),
              child: const Text('PREMIUM', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Anisur Rahman', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const Text('BCS Aspirant', style: TextStyle(color: AppColors.textSecondary)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTag('General Cadre'),
            const SizedBox(width: 8),
            _buildTag('Dhaka Division'),
          ],
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)),
      child: Text(text, style: const TextStyle(fontSize: 10, color: Colors.blueGrey, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatItem('DAYS\nSTREAK', '12', Icons.flash_on, Colors.green),
        const SizedBox(width: 16),
        _buildStatItem('TESTS\nTAKEN', '45', null, Colors.black),
        const SizedBox(width: 16),
        _buildStatItem('ACCURACY', '84%', null, Colors.black),
      ],
    );
  }

  Widget _buildStatItem(String label, String value, IconData? icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
        child: Column(
          children: [
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
                if (icon != null) ...[
                  const SizedBox(width: 4),
                  Icon(icon, size: 14, color: color),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTargetCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00695C),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('MY TARGET', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          const Text('45th BCS Preliminary', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildCountdownBox('14', 'DAYS'),
              const SizedBox(width: 12),
              _buildCountdownBox('08', 'HOURS'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCountdownBox(String val, String unit) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          Text(val, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          Text(unit, style: const TextStyle(color: Colors.white70, fontSize: 8)),
        ],
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        children: [
          _buildMenuItem(Icons.show_chart, 'My Performance', () {}),
          const Divider(),
          _buildMenuItem(Icons.subscriptions_outlined, 'Manage Subscription', () {}),
          const Divider(),
          _buildMenuItem(Icons.settings_outlined, 'Account Settings', () {}),
          const Divider(),
          _buildMenuItem(Icons.help_outline, 'Help & Support', () {}),
          const Divider(),
          _buildMenuItem(Icons.logout, 'Logout', () {
            Navigator.pushReplacementNamed(context, '/login');
          }, isDestructive: true),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isDestructive ? Colors.red : AppColors.primary),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isDestructive ? Colors.red : AppColors.textMain, fontSize: 14)),
      trailing: isDestructive ? null : const Icon(Icons.chevron_right, size: 20, color: AppColors.textSecondary),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 3,
      selectedItemColor: AppColors.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Study'),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'Tests'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
