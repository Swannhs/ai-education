import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Test Analysis', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined, color: Colors.black)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTotalPerformanceCard(),
            const SizedBox(height: 16),
            _buildMiniStatsRow(),
            const SizedBox(height: 24),
            _buildAIInsightCard(),
            const SizedBox(height: 32),
            const Text('Subject Analysis', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildSubjectAnalysisCard(),
            const SizedBox(height: 24),
            _buildTimeAnalysisCard(),
            const SizedBox(height: 24),
            _buildWeakTopicsCard(),
            const SizedBox(height: 40),
            _buildActionButtons(context),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  Widget _buildTotalPerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        children: [
          const Text('TOTAL PERFORMANCE', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          const SizedBox(height: 16),
          RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: '142', style: TextStyle(color: Colors.black, fontSize: 48, fontWeight: FontWeight.bold)),
                TextSpan(text: ' / 200', style: TextStyle(color: AppColors.textSecondary, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.emoji_events_outlined, color: Color(0xFF00B050), size: 16),
                SizedBox(width: 8),
                Text('Rank: 24th of 1,200', style: TextStyle(color: Color(0xFF00695C), fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStatsRow() {
    return Row(
      children: [
        Expanded(child: _buildMiniStat('CORRECT', '156', Colors.green)),
        const SizedBox(width: 12),
        Expanded(child: _buildMiniStat('WRONG', '28', Colors.red)),
        const SizedBox(width: 12),
        Expanded(child: _buildMiniStat('SKIPPED', '16', Colors.blueGrey)),
      ],
    );
  }

  Widget _buildMiniStat(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(bottom: BorderSide(color: color, width: 3)),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
        ],
      ),
    );
  }

  Widget _buildAIInsightCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF00695C), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Text('AI Performance Insight', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            '"Your Math dropped below your average. Revise Ratio and Percentage to boost your score by 15%."',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        children: [
          _buildSubjectProgress('Bangla', 0.85, '85% Accuracy', Colors.green),
          _buildSubjectProgress('English', 0.72, '72% Accuracy', Colors.green),
          _buildSubjectProgress('Mathematics', 0.54, '54% Accuracy', Colors.red),
          _buildSubjectProgress('General Knowledge', 0.80, '80% Accuracy', Colors.green),
        ],
      ),
    );
  }

  Widget _buildSubjectProgress(String name, double value, String accuracy, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              Text(accuracy, style: TextStyle(color: accuracy.contains('54%') ? Colors.red : Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: value, backgroundColor: const Color(0xFFF0F7FF), color: value < 0.6 ? Colors.red : const Color(0xFF00B050), minHeight: 6, borderRadius: BorderRadius.circular(3)),
        ],
      ),
    );
  }

  Widget _buildTimeAnalysisCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF0D47A1), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          const Icon(Icons.timer_outlined, color: Colors.white, size: 32),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Time Analysis', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('TOTAL SPENT', style: TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold)),
              const Text('1h 45m', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              const Text('AVG. PER Q', style: TextStyle(color: Colors.white54, fontSize: 9, fontWeight: FontWeight.bold)),
              const Text('31.5s', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeakTopicsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
              SizedBox(width: 12),
              Text('Weak Topics', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 16),
          _buildWeakItem('Narration'),
          _buildWeakItem('Proverbs'),
          _buildWeakItem('Ancient History'),
        ],
      ),
    );
  }

  Widget _buildWeakItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.circle, color: Colors.red, size: 6),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 56),
            backgroundColor: const Color(0xFF00B050),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          child: const Text('Review Answers'),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.meritList);
                },
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 56), side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('See Merit List', style: TextStyle(color: AppColors.textMain)),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(minimumSize: const Size(0, 56), side: const BorderSide(color: AppColors.border), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16))),
                child: const Text('Practice Weak Areas', style: TextStyle(color: AppColors.textMain)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
