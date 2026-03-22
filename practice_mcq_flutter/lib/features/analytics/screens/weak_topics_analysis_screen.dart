import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class WeakTopicsAnalysisScreen extends StatelessWidget {
  const WeakTopicsAnalysisScreen({super.key});

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
            const Text('PERFORMANCE ANALYSIS', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 8),
            const Text('Weak Topics &\nFocus Areas', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
            const SizedBox(height: 12),
            const Text('We\'ve analyzed your last 500+ practice questions to identify specific patterns in your performance.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
            const SizedBox(height: 24),
            _buildAISummaryCard(),
            const SizedBox(height: 24),
            _buildCriticalAreaCard(),
            const SizedBox(height: 32),
            const Text('Targeted Review Needed', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildTargetedReviewItem('Narration Transformation', '28%', 'Focus on direct to indirect conversion rules.', 0.28, Colors.red),
            _buildTargetedReviewItem('Ratio and Proportion', '35%', 'Struggling with complex word problems.', 0.35, Colors.red),
            _buildTargetedReviewItem('Medieval Bengal History', '54%', 'Timeline memorization is slightly weak.', 0.54, Colors.orange),
            const SizedBox(height: 32),
            const Text('Recommended Lessons', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildLessonCard('Mastering Reported Speech', 'ENGLISH GRAMMAR • 12 videos', 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=500&auto=format&fit=crop&q=60'),
            _buildLessonCard('Ratio Shortcut Techniques', 'MATHEMATICS • 8 videos', 'https://images.unsplash.com/photo-1509228468518-180dd48219d1?w=500&auto=format&fit=crop&q=60'),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    );
  }

  Widget _buildAISummaryCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF00695C), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.white, size: 20),
              const SizedBox(width: 12),
              const Text('AI RECOMMENDATION ENGINE', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'You are struggling with Narration and Ratio.',
            style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold, height: 1.3),
          ),
          const SizedBox(height: 12),
          const Text(
            'Your accuracy in these areas has dropped below 35% compared to last month. Most errors occur in complex transformation rules and inverse proportions.',
            style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF00695C),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Get Personalized Study Plan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                SizedBox(width: 8),
                Icon(Icons.add, size: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCriticalAreaCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Critical Area', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
          const Text('English Grammar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text('42%', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.red)),
              const SizedBox(width: 8),
              const Text('Avg. Accuracy', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 12),
          const Text('You spend 3x longer on English questions than Math. Focus on rules rather than intuition.', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.5)),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('COMPLEXITY ANALYSIS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
              Icon(Icons.warning, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTargetedReviewItem(String topic, String accuracy, String desc, double progress, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
               Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Icon(Icons.psychology_outlined, color: color, size: 20)),
               Column(
                 crossAxisAlignment: CrossAxisAlignment.end,
                 children: [
                   const Text('ACCURACY', style: TextStyle(color: AppColors.textSecondary, fontSize: 8, fontWeight: FontWeight.bold)),
                   Text(accuracy, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
                 ],
               ),
            ],
          ),
          const SizedBox(height: 12),
          Text(topic, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12, height: 1.4)),
          const SizedBox(height: 16),
          LinearProgressIndicator(value: progress, backgroundColor: const Color(0xFFF0F7FF), color: color, minHeight: 6, borderRadius: BorderRadius.circular(3)),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(accuracy.contains('54%') ? 'Review Now' : 'Practice Now'),
          ),
        ],
      ),
    );
  }

  Widget _buildLessonCard(String title, String subtitle, String imageUrl) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.network(imageUrl, height: 140, width: double.infinity, fit: BoxFit.cover),
                const CircleAvatar(backgroundColor: Colors.white24, radius: 20, child: Icon(Icons.play_arrow, color: Colors.white)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subtitle, style: const TextStyle(color: Color(0xFF00695C), fontSize: 10, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 12),
                const Row(
                  children: [
                    Text('Start Lessons', style: TextStyle(color: AppColors.textMain, fontSize: 12, fontWeight: FontWeight.w600)),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 16, color: AppColors.textMain),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
