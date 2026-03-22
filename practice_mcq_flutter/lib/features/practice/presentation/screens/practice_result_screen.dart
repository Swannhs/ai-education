import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';
import '../../../core/routing/app_router.dart';

class PracticeResultScreen extends StatelessWidget {
  final int score;
  final int total;
  
  const PracticeResultScreen({super.key, this.score = 0, this.total = 3});

  @override
  Widget build(BuildContext context) {
    final double accuracy = total > 0 ? (score / total) * 100 : 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Performance Summary', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('TOTAL SCORE', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 8),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: '$score ', style: const TextStyle(color: Colors.green, fontSize: 48, fontWeight: FontWeight.bold)),
                  TextSpan(text: '/ $total', style: const TextStyle(color: AppColors.textSecondary, fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildSummaryCard('${accuracy.toInt()}%', 'ACCURACY', Icons.check_circle_outline, Colors.blue),
                const SizedBox(width: 16),
                _buildSummaryCard('02:15', 'TIME SPENT', Icons.timer_outlined, Colors.orange),
              ],
            ),
            const SizedBox(height: 32),
            const Text('DETAILED BREAKDOWN', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _buildBreakdownChip('$score Correct', Colors.green),
                _buildBreakdownChip('${total - score} Wrong', Colors.red),
              ],
            ),
            const SizedBox(height: 32),
            _buildAIInsightCard(),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text('Practice Again'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.home),
              child: const Center(child: Text('Return to Dashboard', style: TextStyle(fontWeight: FontWeight.bold))),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3),
    );
  }

  Widget _buildSummaryCard(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
        child: Column(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(val, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildBreakdownChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8, height: 8, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildAIInsightCard() {
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
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.psychology, color: Colors.white)),
          const SizedBox(height: 16),
          const Text('AI INSIGHT', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Great job! You\'ve mastered the basics. Our AI suggests focusing on "Complex Sentences" next to reach the advanced tier.',
            style: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }
}
