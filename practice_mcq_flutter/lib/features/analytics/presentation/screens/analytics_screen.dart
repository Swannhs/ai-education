import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../core/routing/app_router.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../domain/performance_stats.dart';
import '../providers/analytics_provider.dart';

class AnalyticsScreen extends ConsumerWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final reportAsync = ref.watch(performanceReportProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
        title: const Text('BCS Prep Pro', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 16, 
              backgroundColor: Colors.orange,
              child: Text(user?.name.substring(0, 1).toUpperCase() ?? 'A', style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: reportAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (report) => SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Performance Insights', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('Good morning, ${user?.name}. You\'re in the top 15% of candidates this week.', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              const SizedBox(height: 32),
              _buildStatCards(report),
              const SizedBox(height: 24),
              _buildWeeklyTrendCard(),
              const SizedBox(height: 24),
              _buildCriticalWeaknessCard(context, report),
              const SizedBox(height: 24),
              _buildAIRecommendationCard(report),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildStatCards(PerformanceSummary report) {
    return Column(
      children: [
        _buildStatCard('OVERALL ACCURACY', '${report.overallScore}%', Icons.track_changes, Colors.green, subtitle: '+2.5% vs last week'),
        const SizedBox(height: 12),
        _buildStatCard('TOTAL QUESTIONS', '${report.totalQuestionsSolved}', Icons.quiz_outlined, Colors.blue, subtitle: 'Keep it up!'),
        const SizedBox(height: 12),
        _buildStatCard('TESTS TAKEN', '${report.totalTestsTaken}', Icons.assignment_outlined, Colors.orange, subtitle: 'Weekly Goal: 5'),
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

  Widget _buildCriticalWeaknessCard(BuildContext context, PerformanceSummary report) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Subject Performance', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          ...report.subjectStats.map((s) => _buildWeaknessItem(s.subjectName, s.scorePercent, '${(s.scorePercent * 100).toInt()}%')),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
               Navigator.pushNamed(context, AppRouter.subjectPerformance);
            },
            style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48), side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('View Detailed Analysis', style: TextStyle(color: AppColors.textMain, fontSize: 13)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeaknessItem(String subject, double progress, String percentage) {
    final Color color = progress < 0.6 ? Colors.red : (progress < 0.8 ? Colors.orange : Colors.green);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subject, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
              Text(percentage, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress, backgroundColor: const Color(0xFFF0F7FF), color: color, minHeight: 4, borderRadius: BorderRadius.circular(2)),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationCard(PerformanceSummary report) {
    final weakTopic = report.weakTopics.first;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00695C),
        borderRadius: BorderRadius.circular(24),
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
          Text(
            'Improve "${weakTopic.topicName}"',
            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
          const SizedBox(height: 12),
          Text(
            weakTopic.aiSuggestion,
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
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
            child: const Text('Start Focused Practice', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
