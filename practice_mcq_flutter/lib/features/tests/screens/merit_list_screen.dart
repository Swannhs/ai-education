import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class MeritListScreen extends StatelessWidget {
  const MeritListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Merit List', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
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
            _buildMyPerformanceCard(),
            const SizedBox(height: 32),
            _buildFilters(),
            const SizedBox(height: 24),
            _buildRankItem('1', 'Tamvir Ahmed', 'BCS Aspirant', '198.0', '99% Accuracy', isTop: true, medalColor: Colors.orange),
            _buildRankItem('2', 'Nusrat Jahan', 'Same Exam Group', '196.5', '98% Accuracy', isTop: true, medalColor: Colors.grey),
            _buildRankItem('3', 'Arifur Rahman', 'Top 0.1% Participant', '194.0', '97.5% Accuracy', isTop: true, medalColor: Colors.brown),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Text('...', style: TextStyle(color: AppColors.textSecondary, fontSize: 24)),
            ),
            _buildRankItem('42', 'Rakibul Islam', 'Top 1% Nationwide', '184.5', '94% Accuracy', isMe: true),
            _buildRankItem('43', 'Kazi Farhan', 'Dhaka University', '184.2', '93% Accuracy'),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2), // Index 2 is Merit (Rankings)
    );
  }

  Widget _buildMyPerformanceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00B050),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: const Color(0xFF00B050).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('CURRENT PERFORMANCE', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(12)),
                child: const Icon(Icons.emoji_events, color: Colors.white, size: 24),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text('Your Rank: 42nd', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          const Text('of 12,450 participants', style: TextStyle(color: Colors.white70, fontSize: 13)),
          const SizedBox(height: 32),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildPerformanceStat('SCORE', '184.5 / 200'),
              const Spacer(),
              _buildPerformanceStat('PERCENTILE', '99.6%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildFilters() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All', true),
          const SizedBox(width: 8),
          _buildFilterChip('Friends', false),
          const SizedBox(width: 8),
          _buildFilterChip('Same Exam Group', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF004D40) : const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(color: isSelected ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }

  Widget _buildRankItem(String rank, String name, String subtitle, String score, String accuracy, {bool isTop = false, Color? medalColor, bool isMe = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isMe ? const Color(0xFFE0F2F1) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isMe ? const Color(0xFF00B050) : AppColors.border.withOpacity(0.5), width: isMe ? 1 : 1),
        boxShadow: isTop ? [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))] : null,
      ),
      child: Row(
        children: [
          if (isTop)
             Container(
               width: 32,
               child: Icon(Icons.emoji_events, color: medalColor, size: 24),
             )
          else
            Container(
              width: 32,
              child: Text(rank, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
          const SizedBox(width: 12),
          CircleAvatar(
            radius: 20,
            backgroundImage: const NetworkImage('https://i.pravatar.cc/150?img=11'),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(score, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Color(0xFF00695C))),
              Text(accuracy, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
