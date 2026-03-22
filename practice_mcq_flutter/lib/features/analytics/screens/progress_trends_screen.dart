import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class ProgressTrendsScreen extends StatelessWidget {
  const ProgressTrendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Trends', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimeSpentChart(),
            const SizedBox(height: 32),
            _buildAccuracyTrendChart(),
            const SizedBox(height: 32),
            _buildMockResultTimeline(),
            const SizedBox(height: 32),
            _buildMonthlyComparisonCard(),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2), // Routine or Analytics? Analytics tab isn't in bottom nav
    );
  }

  Widget _buildTimeSpentChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Weekly Study Time', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              _buildPeriodSelector('This Week'),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar('Mon', 0.4, '1.5h'),
              _buildBar('Tue', 0.7, '3.2h'),
              _buildBar('Wed', 0.9, '4.5h', isHighlighted: true),
              _buildBar('Thu', 0.5, '2.1h'),
              _buildBar('Fri', 0.6, '2.8h'),
              _buildBar('Sat', 0.3, '1.2h'),
              _buildBar('Sun', 0.8, '3.8h'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double heightFactor, String label, {bool isHighlighted = false}) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 8, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(
          width: 8,
          height: 100 * heightFactor,
          decoration: BoxDecoration(
            color: isHighlighted ? AppColors.primary : const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 8),
        Text(day, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildAccuracyTrendChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Accuracy Trend', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          const Text('Your accuracy in Math and English is improving steadily.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          const Center(
            child: Icon(Icons.show_chart, size: 100, color: AppColors.primary), // Placeholder for real chart
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem('Current Week', AppColors.primary),
              _buildLegendItem('Last Week', Colors.grey),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 10)),
      ],
    );
  }

  Widget _buildMockResultTimeline() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Mock Test History', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildTimelineItem('Mock #12', '75/100', 'Top 10%', true),
        _buildTimelineItem('Mock #11', '68/100', 'Top 25%', false),
        _buildTimelineItem('Mock #10', '62/100', 'Top 40%', false),
      ],
    );
  }

  Widget _buildTimelineItem(String title, String score, String rank, bool isLatest) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: isLatest ? const Color(0xFFE8F5E9) : const Color(0xFFF5F5F5), shape: BoxShape.circle),
            child: Icon(Icons.assessment_outlined, color: isLatest ? AppColors.primary : Colors.grey, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Score: $score', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
              ],
            ),
          ),
          Text(rank, style: TextStyle(color: isLatest ? AppColors.primary : Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildMonthlyComparisonCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF00695C), Color(0xFF00897B)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Text('Compared to Last Month', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGrowthStat('+24%', 'Study Time'),
              _buildGrowthStat('+10%', 'Accuracy'),
              _buildGrowthStat('-15%', 'Mistakes'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGrowthStat(String value, String label) {
    return Column(
      children: [
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
      ],
    );
  }

  Widget _buildPeriodSelector(String current) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Text(current, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
          const Icon(Icons.arrow_drop_down, size: 16),
        ],
      ),
    );
  }
}
