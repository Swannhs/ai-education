import 'package:flutter/material.dart';
import '../../core/routing/app_router.dart';
import '../../core/theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _buildDrawerHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(context, 'Dashboard', Icons.dashboard_outlined, AppRouter.home),
                _buildDrawerItem(context, 'Study Library', Icons.book_outlined, AppRouter.learnLibrary),
                _buildDrawerItem(context, 'Practice History', Icons.history, AppRouter.testHistory),
                _buildDrawerItem(context, 'Mock Tests', Icons.timer_outlined, AppRouter.testList),
                _buildDrawerItem(context, 'Daily Routine', Icons.calendar_today_outlined, AppRouter.routine),
                _buildDrawerItem(context, 'AI Personal Mentor', Icons.auto_awesome_outlined, AppRouter.aiRecommendations),
                _buildDrawerItem(context, 'My Analytics', Icons.analytics_outlined, AppRouter.analytics),
                const Divider(),
                _buildDrawerItem(context, 'Premium Plans', Icons.workspace_premium_outlined, AppRouter.subscription),
                _buildDrawerItem(context, 'Settings', Icons.settings_outlined, AppRouter.settings),
                _buildDrawerItem(context, 'Help & FAQ', Icons.help_outline, AppRouter.helpFaq),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text('Logout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, AppRouter.login);
                  },
                ),
              ],
            ),
          ),
          _buildDrawerFooter(),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Color(0xFF004D40),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white24,
            child: Icon(Icons.person, size: 35, color: Colors.white),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Anisur Rahman', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('BCS Aspirant', style: TextStyle(color: Colors.white70, fontSize: 12)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                  child: const Text('PREMIUM', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.black)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, String title, IconData icon, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textMain, size: 22),
      title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
      onTap: () {
        Navigator.pop(context); // Close drawer
        Navigator.pushNamed(context, route);
      },
    );
  }

  Widget _buildDrawerFooter() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const Text('GovPrep BD v1.0.0', style: TextStyle(color: Colors.grey, fontSize: 10)),
          const SizedBox(height: 4),
          const Text('Made with ❤️ in Bangladesh', style: TextStyle(color: Colors.grey, fontSize: 8)),
        ],
      ),
    );
  }
}
