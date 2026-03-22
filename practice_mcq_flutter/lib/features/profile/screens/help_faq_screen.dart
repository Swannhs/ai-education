import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class HelpFAQScreen extends StatelessWidget {
  const HelpFAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Help & FAQ', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 32),
            const Text('Popular Questions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildFAQTile('How to reset my progress?', 'You can reset your progress for individual subjects by going to the Subject Detail screen and tapping the 3-dot menu.'),
            _buildFAQTile('Is the AI tutor free to use?', 'Free users have a limit of 10 AI inquiries per day. Premium users have unlimited access.'),
            _buildFAQTile('How to join a live mock test?', 'Go to the Tests tab and look for the "Live Now" banner. Tap on "Join Live Exam" to participate.'),
            _buildFAQTile('When are results published?', 'Live test results are usually published within 15-30 minutes after the test session ends.'),
            _buildFAQTile('How to contact support?', 'Scroll down to the bottom of this page or go to "Help / Contact" in your profile.'),
            const SizedBox(height: 32),
            const Text('Categories', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildCategoryGrid(),
            const SizedBox(height: 32),
            _buildContactCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search for help topics...',
        prefixIcon: const Icon(Icons.search),
        fillColor: const Color(0xFFF1F8E9),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _buildFAQTile(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      color: Colors.white,
      child: ExpansionTile(
        title: Text(question, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(answer, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return Column(
      children: [
        Row(
          children: [
            _buildCategoryItem('Subscription', Icons.payment, Colors.blue),
            const SizedBox(width: 16),
            _buildCategoryItem('Exams & Tests', Icons.timer, Colors.orange),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildCategoryItem('Study Material', Icons.book, Colors.green),
            const SizedBox(width: 16),
            _buildCategoryItem('Account', Icons.person, Colors.purple),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryItem(String title, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.headset_mic, color: AppColors.primary, size: 40),
          const SizedBox(height: 16),
          const Text('Need more help?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Our support team is available from 10 AM to 10 PM.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildContactButton('Email Us', Icons.email, Colors.blue),
              _buildContactButton('Call Support', Icons.phone, Colors.green),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactButton(String label, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      ],
    );
  }
}
