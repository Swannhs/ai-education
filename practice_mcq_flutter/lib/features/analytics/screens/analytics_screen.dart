import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';
import '../../../core/routing/app_router.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

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
            child: CircleAvatar(radius: 16, backgroundColor: Colors.orange),
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
            const Text('Performance Insights', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Good morning, Rakibul. You\'re in the top 15% of candidates this week.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            const SizedBox(height: 32),
            _buildStatCards(),
            const SizedBox(height: 24),
            _buildWeeklyTrendCard(),
            const SizedBox(height: 24),
            _buildCriticalWeaknessCard(context),
            const SizedBox(height: 24),
            _buildAIRecommendationCard(),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildStatCards() {
    return Column(
      children: [
        _buildStatCard('OVERALL ACCURACY', '78.5%', Icons.track_changes, Colors.green, subtitle: '+2.5% vs last week'),
        const SizedBox(height: 12),
        _buildStatCard('TEST RANK', '#1,240', Icons.leaderboard_outlined, Colors.blue, subtitle: 'Better than 850'),
        const SizedBox(height: 12),
        _buildStatCard('TOTAL STUDY TIME', '32.5h', Icons.access_time, Colors.orange, subtitle: 'Goal: 40h'),
      ],
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color, {required String subtitle}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(6)),
            child: Text(subtitle, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyTrendCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Weekly Progress Trend', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.circle, size: 8, color: Color(0xFF00695C)),
                  SizedBox(width: 4),
                  Text('Score', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                  SizedBox(width: 12),
                  Icon(Icons.circle, size: 8, color: Color(0xFFE0F2F1)),
                  SizedBox(width: 4),
                  Text('Time', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar('Mon', 0.6, 0.4),
                _buildBar('Tue', 0.8, 0.5),
                _buildBar('Wed', 0.4, 0.3),
                _buildBar('Thu', 0.9, 0.7),
                _buildBar('Fri', 0.7, 0.4),
                _buildBar('Sat', 0.6, 0.4),
                _buildBar('Sun', 0.3, 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double topVal, double bottomVal) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(width: 20, height: 120, decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(4))),
            Container(width: 20, height: 120 * topVal, decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(4))),
            Container(width: 20, height: 120 * bottomVal, decoration: BoxDecoration(color: const Color(0xFF00695C), borderRadius: BorderRadius.circular(4))),
          ],
        ),
        const SizedBox(height: 12),
        Text(day, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ],
    );
  }

  Widget _buildCriticalWeaknessCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Critical Weakness', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildWeaknessItem('General Mental Ability', 0.42, '42%'),
          _buildWeaknessItem('Bangladesh Affairs', 0.54, '54%'),
          _buildWeaknessItem('International Affairs', 0.39, '39%'),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
               Navigator.pushNamed(context, AppRouter.subjectPerformance);
            },
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48), side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('View All Subjects', style: TextStyle(color: AppColors.textMain, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaknessItem(String subject, double progress, String percentage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subject, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              Text(percentage, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.red)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, backgroundColor: const Color(0xFFF0F7FF), color: Colors.red, minHeight: 4, borderRadius: BorderRadius.circular(2)),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00695C),
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/carbon-fibre.png'),
          opacity: 0.1,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.white, size: 24),
              SizedBox(width: 12),
              Text('AI TUTOR RECOMMENDATION', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Focus on "Set Theory" and "Probability" tonight.',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
          const SizedBox(height: 12),
          const Text(
            'Based on your recent Mock Test #04, you lost 8 points in Mathematics due to speed. We\'ve curated a focused 30-minute practice session to help you bridge this gap.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF00695C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Start Recommended Practice', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(minimumSize: const Size(double.infinity, 52), foregroundColor: Colors.white),
            child: const Text('Review Past Mistakes', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline)),
          ),
        ],
      ),
    );
  }
}
