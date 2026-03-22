import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class FavoritesLibraryScreen extends StatelessWidget {
  const FavoritesLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Favorites Library', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildTotalSavedCard(),
            const SizedBox(height: 16),
            _buildAIGroupingInfo(),
            const SizedBox(height: 24),
            _buildSubjectFilters(),
            const SizedBox(height: 24),
            _buildQuestionCard('ENGLISH - SYNONYMS', 'What is the synonym of the word \'Pinnacle\'? This question was frequent...', 'Saved 2 days ago'),
            _buildQuestionCard('MATH - PERCENTAGE', 'If the price of sugar increases by 25%, by what percentage should a family...', 'Saved 5 days ago'),
            _buildQuestionCard('GENERAL KNOWLEDGE', 'Who was the first President of Bangladesh? (Historical context and...', 'Saved 1 week ago'),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1), // Library tab
    );
  }

  Widget _buildTotalSavedCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total Saved', style: TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(text: '128 ', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black)),
                        TextSpan(text: 'Questions', style: TextStyle(fontSize: 14, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
              Container(padding: const EdgeInsets.all(12), decoration: const BoxDecoration(color: Color(0xFFE8F5E9), shape: BoxShape.circle), child: const Icon(Icons.collections_bookmark, color: Color(0xFF1B5E20))),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: const Color(0xFF00B074),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.play_circle_fill, size: 20), SizedBox(width: 8), Text('Practice All', style: TextStyle(fontWeight: FontWeight.bold))]),
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 52),
              backgroundColor: const Color(0xFF5A84FF),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.auto_awesome, size: 20), SizedBox(width: 8), Text('Smart Selection', style: TextStyle(fontWeight: FontWeight.bold))]),
          ),
        ],
      ),
    );
  }

  Widget _buildAIGroupingInfo() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(16)),
      child: const Row(
        children: [
          Icon(Icons.insights, color: Color(0xFF0D47A1), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: Text('AI grouped your favorites into English (45), Math (32), and GK (51)', style: TextStyle(color: Color(0xFF0D47A1), fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectFilters() {
    final filters = ['All Subjects', 'English', 'Bangla', 'Math'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) => Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: f == 'All Subjects' ? Colors.black : const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(f, style: TextStyle(color: f == 'All Subjects' ? Colors.white : const Color(0xFF0D47A1), fontSize: 13, fontWeight: FontWeight.bold)),
        )).toList(),
      ),
    );
  }

  Widget _buildQuestionCard(String subject, String question, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)), child: Text(subject, style: const TextStyle(color: Color(0xFF0D47A1), fontSize: 9, fontWeight: FontWeight.bold))),
              const Icon(Icons.more_vert, color: AppColors.border, size: 20),
            ],
          ),
          const SizedBox(height: 16),
          Text(question, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, height: 1.4)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.access_time, color: AppColors.textSecondary, size: 14),
                  const SizedBox(width: 6),
                  Text(time, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
              Row(
                children: [
                  const Text('Practice', style: TextStyle(color: Color(0xFF00B074), fontSize: 11, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 4),
                  const Icon(Icons.chevron_right, color: Color(0xFF00B074), size: 14),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
