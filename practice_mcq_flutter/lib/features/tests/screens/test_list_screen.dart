import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class TestListScreen extends StatelessWidget {
  const TestListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildFeaturedMockTest(),
              const SizedBox(height: 24),
              _buildAIRecommendationCard(),
              const SizedBox(height: 32),
              _buildTabs(),
              const SizedBox(height: 24),
              _buildTestCard(
                title: 'General Knowledge Daily Quiz',
                subtitle: '30m • 40 Qs',
                status: 'LIVE',
                statusColor: Colors.green,
                timeInfo: 'Ends in 45m',
                buttonLabel: 'Join Now',
                isLive: true,
              ),
              _buildTestCard(
                title: 'Math Practice Test #4',
                subtitle: 'Today 9:00 PM • 45m',
                status: 'UPCOMING',
                statusColor: Colors.blue,
                timeInfo: 'Starts in 2h',
                buttonLabel: 'Remind Me',
              ),
              _buildTestCard(
                title: 'English Grammar - Parts of Speech',
                subtitle: 'Oct 12, 2023 • 25 Qs',
                status: 'ARCHIVE',
                statusColor: Colors.grey,
                timeInfo: 'Completed',
                buttonLabel: 'View Results',
                isArchive: true,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        CircleAvatar(radius: 18, child: Icon(Icons.person)),
        SizedBox(width: 12),
        Text('GovPrep BD', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        Spacer(),
        Icon(Icons.notifications_none, color: AppColors.primary),
      ],
    );
  }

  Widget _buildFeaturedMockTest() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00B050),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLiveBadge(),
          const SizedBox(height: 12),
          const Text('FEATURED MEGA MOCK', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          const Text('Full BCS Preliminary Mock Test #12', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Row(
            children: [
              Icon(Icons.timer_outlined, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text('120m', style: TextStyle(color: Colors.white, fontSize: 12)),
              SizedBox(width: 16),
              Icon(Icons.edit_note, color: Colors.white, size: 16),
              SizedBox(width: 4),
              Text('200 Qs', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF004D40), foregroundColor: Colors.white),
            child: const Text('Join Live Exam'),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, size: 8, color: Colors.white),
          SizedBox(width: 4),
          Text('LIVE NOW', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.blue),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Based on your progress, attempt the English Subject Mock Test next.',
              style: TextStyle(fontSize: 12, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          _buildTab('Live', true),
          _buildTab('Upcoming', false),
          _buildTab('Archive', false),
        ],
      ),
    );
  }

  Widget _buildTab(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: AppColors.border.withOpacity(0.5)) : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTestCard({
    required String title,
    required String subtitle,
    required String status,
    required Color statusColor,
    required String timeInfo,
    required String buttonLabel,
    bool isLive = false,
    bool isArchive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(status, style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              Text(timeInfo, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 20),
          if (isArchive)
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48), side: const BorderSide(color: AppColors.border)),
              child: Text(buttonLabel, style: const TextStyle(color: AppColors.textMain)),
            )
          else if (isLive)
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 48), backgroundColor: const Color(0xFF00695C)),
              child: Text(buttonLabel),
            )
          else // Upcoming
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.notifications_none, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(buttonLabel, style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 1,
      selectedItemColor: AppColors.primary,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
        BottomNavigationBarItem(icon: Icon(Icons.timer), label: 'TESTS'),
        BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'RESOURCES'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'PROFILE'),
      ],
    );
  }
}
