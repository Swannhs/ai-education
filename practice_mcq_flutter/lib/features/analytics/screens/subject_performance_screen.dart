import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class SubjectPerformanceScreen extends StatelessWidget {
  const SubjectPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Performance Analytics', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold, fontSize: 16)),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subject Accuracy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('Last 30 Days', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
            const SizedBox(height: 16),
            _buildAccuracyGrid(),
            const SizedBox(height: 32),
            const Text('Syllabus Progress', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildSyllabusProgressCard(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Recent Tests: Mathematics', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: const Text('View All', style: TextStyle(color: Color(0xFF00695C), fontSize: 12, fontWeight: FontWeight.bold))),
              ],
            ),
            const SizedBox(height: 12),
            _buildRecentTestItem('Weekly Mock Test #12', 'Oct 14, 2023 • 50 Questions', '48/50', '96%', Colors.green),
            _buildRecentTestItem('Geometry Practice Set', 'Oct 12, 2023 • 25 Questions', '22/25', '88%', Colors.blue),
            _buildRecentTestItem('Mental Ability Drill', 'Oct 10, 2023 • 30 Questions', '28/30', '93%', Colors.orange),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1), // Subjects tab
    );
  }

  Widget _buildAccuracyGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.4,
      children: [
        _buildAccuracyCard('BANGLA', '84.2%', Icons.eco_outlined, Colors.green, subtitle: '+2.4%'),
        _buildAccuracyCard('ENGLISH', '76.5%', Icons.translate, Colors.blue, subtitle: '-1.2%', isPositive: false),
        _buildAccuracyCard('MATHEMATICS', '92.0%', Icons.functions, Colors.orange, subtitle: '+5.1%'),
        _buildAccuracyCard('GK', '68.8%', Icons.public, Colors.purple, subtitle: 'Stable'),
      ],
    );
  }

  Widget _buildAccuracyCard(String label, String value, IconData icon, Color color, {required String subtitle, bool isPositive = true}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 16)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(color: subtitle == 'Stable' ? Colors.blue.withOpacity(0.1) : (isPositive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1)), borderRadius: BorderRadius.circular(4)),
                child: Text(subtitle, style: TextStyle(color: subtitle == 'Stable' ? Colors.blue : (isPositive ? Colors.green : Colors.red), fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSyllabusProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          _buildSyllabusItem('Mathematics', 'Arithmetic & Geometry modules completed', 0.85, '85%', Colors.green),
          _buildSyllabusItem('English Literature', 'Modern Age period remaining', 0.62, '62%', Colors.blue),
          _buildSyllabusItem('Bangladesh Affairs', 'Economic survey 2024 pending', 0.44, '44%', Colors.orange),
        ],
      ),
    );
  }

  Widget _buildSyllabusItem(String name, String status, double progress, String percentage, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  Text(status, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                ],
              ),
              Text(percentage, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(value: progress, backgroundColor: Colors.white, color: color, minHeight: 6, borderRadius: BorderRadius.circular(3)),
        ],
      ),
    );
  }

  Widget _buildRecentTestItem(String title, String date, String score, String accuracy, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: Icon(Icons.assignment_outlined, color: color)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text('ACCURACY: $accuracy', style: const TextStyle(color: AppColors.textSecondary, fontSize: 9, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
