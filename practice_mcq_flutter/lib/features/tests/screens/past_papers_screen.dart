import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class PastPapersScreen extends StatelessWidget {
  const PastPapersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text('Past Papers', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
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
            _buildFilterChips(),
            const SizedBox(height: 20),
            _buildAIInsightBanner(),
            const SizedBox(height: 32),
            _buildSectionTitle('AVAILABLE PAPERS'),
            const SizedBox(height: 16),
            _buildPaperCard('45th BCS Preliminary (2023)', '200 Questions', '120 Minutes'),
            _buildPaperCard('44th BCS Preliminary (2022)', '200 Questions', '120 Minutes'),
            _buildPaperCard('43rd BCS Preliminary (2021)', '200 Questions', '120 Minutes'),
            _buildPaperCard('Combined 5 Bank Officer\n(2023)', '100 Questions', '60 Minutes'),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2), // Practice tab
    );
  }

  Widget _buildFilterChips() {
    final filters = ['BCS', 'Bank', 'Primary', '2023', '2022'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) => Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: f == 'BCS' ? const Color(0xFF00B074) : const Color(0xFFF0F7FF),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(f, style: TextStyle(color: f == 'BCS' ? Colors.white : const Color(0xFF0D47A1), fontSize: 13, fontWeight: FontWeight.bold)),
        )).toList(),
      ),
    );
  }

  Widget _buildAIInsightBanner() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.auto_awesome, color: Color(0xFF00B074), size: 18),
                  const SizedBox(width: 8),
                  const Text('AI Insight', style: TextStyle(color: Color(0xFF004D40), fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: const Color(0xFF004D40), borderRadius: BorderRadius.circular(4)), child: const Text('NEW', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'These topics appeared most often in the last 5 years: Constitutional Law, Sentence Correction, and Medieval History.',
            style: TextStyle(color: Color(0xFF004D40), fontSize: 12, height: 1.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, fontWeight: FontWeight.bold, letterSpacing: 0.5)));
  }

  Widget _buildPaperCard(String title, String questions, String duration) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, height: 1.3))),
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.bookmark_border, color: Color(0xFF0D47A1), size: 20)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.assignment_outlined, color: AppColors.textSecondary, size: 14),
              const SizedBox(width: 6),
              Text(questions, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              const SizedBox(width: 12),
              const Text('•', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(width: 12),
              const Icon(Icons.access_time, color: AppColors.textSecondary, size: 14),
              const SizedBox(width: 6),
              Text(duration, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
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
              elevation: 0,
            ),
            child: const Text('Start Practice', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
