import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class TestHistoryScreen extends StatelessWidget {
  const TestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text('BCS Prep Pro', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(radius: 16, backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=11')),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Test History', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Review your performance across 24 completed examinations.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 32),
            _buildOverviewCards(),
            const SizedBox(height: 32),
            _buildSearchAndFilters(),
            const SizedBox(height: 24),
            _buildHistoryItem('MOCK EXAM', 'October 24, 2023', '45th BCS Preliminary Full Mock - 04', '154/200', '86%', 'Bangladesh Affairs • 2h 30m', Colors.green),
            _buildHistoryItem('SUBJECT TEST', 'October 22, 2023', 'General Science: Energy & Mechanics', '42/50', '84%', 'General Science • 45m', Colors.blue),
            _buildHistoryItem('ROUTINE MCQ', 'October 20, 2023', 'Daily English Vocabulary Drill - #142', '12/20', '60%', 'English Literature • 15m', Colors.orange),
            const SizedBox(height: 24),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Load More Archives', style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold)),
                    Icon(Icons.keyboard_arrow_down, size: 20, color: AppColors.textMain),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3), // Tests tab
    );
  }

  Widget _buildOverviewCards() {
    return Column(
      children: [
        _buildOverviewCard('AVERAGE SCORE', '78.5%', Icons.check_circle_outline, Colors.green),
        const SizedBox(height: 12),
        _buildOverviewCard('AVG. ACCURACY', '92.0%', Icons.speed_outlined, Colors.blue),
        const SizedBox(height: 12),
        _buildOverviewCard('TESTS THIS WEEK', '08', Icons.calendar_today_outlined, Colors.orange),
      ],
    );
  }

  Widget _buildOverviewCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('SEARCH EXAMINATION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
          child: const TextField(
            decoration: InputDecoration(hintText: 'Title or subject...', hintStyle: TextStyle(fontSize: 14, color: AppColors.textSecondary), border: InputBorder.none, icon: Icon(Icons.search, size: 20)),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildFilterDropdown('All Subjects')),
            const SizedBox(width: 12),
            Expanded(child: _buildFilterDropdown('Newest First')),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(value, style: const TextStyle(fontSize: 13, color: AppColors.textMain, fontWeight: FontWeight.w500)),
          const Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.textSecondary),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String type, String date, String title, String score, String accuracy, String subtitle, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)), child: Text(type, style: TextStyle(color: color, fontSize: 8, fontWeight: FontWeight.bold))),
              Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.4)),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.library_books_outlined, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              const Text('Bangladesh affairs', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              const SizedBox(width: 16),
              const Icon(Icons.access_time, size: 14, color: AppColors.textSecondary),
              const SizedBox(width: 6),
              const Text('2h 30m', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStat('SCORE', score),
              const SizedBox(width: 40),
              _buildStat('ACCURACY', accuracy),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: const Color(0xFFF0F7FF),
              foregroundColor: const Color(0xFF0D47A1),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Review', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: value.contains('12/') ? Colors.red : Colors.black)),
      ],
    );
  }
}
