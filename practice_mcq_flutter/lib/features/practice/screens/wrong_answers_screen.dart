import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class WrongAnswersScreen extends StatelessWidget {
  const WrongAnswersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Wrong Answers', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildBacklogCard(),
            const SizedBox(height: 24),
            _buildAIInsightAlert(),
            const SizedBox(height: 32),
            _buildFilterChips(),
            const SizedBox(height: 24),
            _buildQuestionCard('ENGLISH', 'HARD', 'May 24, 2024', 'Which one is the correct indirect speech of: He said, "I have been...', 'Attempted: 3 times'),
            _buildQuestionCard('MATH', 'MEDIUM', 'Yesterday', 'If the area of a circle is 154 square cm, then its circumference is?', 'Attempted: 1 time'),
            _buildQuestionCard('BANGLA', 'HARD', 'May 31, 2024', 'রবীন্দ্রনাথ ঠাকুর কত সালে নোবেল পুরস্কার লাভ করেন? (In which year did Rabindranat...', 'Attempted: 2 times'),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 3), // Often mapped to a specialized "Review" tab
    );
  }

  Widget _buildBacklogCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('TOTAL BACKLOG', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                  SizedBox(height: 8),
                  Text('128 Questions to Review', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.delete_outline, color: Colors.green)),
            ],
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.trending_down, color: Colors.blue, size: 20),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('TOP WEAKNESS', style: TextStyle(color: Colors.blue, fontSize: 8, fontWeight: FontWeight.bold)),
                    Text('English Grammar (Narration)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_arrow, size: 20),
            label: const Text('Practice All'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              foregroundColor: const Color(0xFF00695C),
              side: const BorderSide(color: Color(0xFF00695C)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Clear Mastered'),
          ),
        ],
      ),
    );
  }

  Widget _buildAIInsightAlert() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: Colors.blue, width: 4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb, color: Colors.blue, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: const TextSpan(
                style: TextStyle(color: AppColors.textMain, fontSize: 13, height: 1.5),
                children: [
                  TextSpan(text: 'AI Insight: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(text: 'You\'ve missed 4 questions on '),
                  TextSpan(text: '\'Prepositions\'', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)),
                  TextSpan(text: ' recently. Focus on this topic to boost your score by ~3.5%.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip('All Subjects', isSelected: true),
          _buildChip('Bangla'),
          _buildChip('English'),
          _buildChip('Math'),
        ],
      ),
    );
  }

  Widget _buildChip(String label, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF00695C) : const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(label, style: TextStyle(color: isSelected ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13)),
    );
  }

  Widget _buildQuestionCard(String subject, String diff, String date, String text, String attempted) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _buildTag(subject, const Color(0xFFE3F2FD), Colors.blue),
                  const SizedBox(width: 8),
                  _buildTag(diff, const Color(0xFFFFEBEE), Colors.red),
                ],
              ),
              Text(date, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 16),
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.history, color: AppColors.textSecondary, size: 14),
                  const SizedBox(width: 8),
                  Text(attempted, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
              Row(
                children: const [
                  Text('Retry', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold, fontSize: 12)),
                  Icon(Icons.chevron_right, color: Color(0xFF00695C), size: 16),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
