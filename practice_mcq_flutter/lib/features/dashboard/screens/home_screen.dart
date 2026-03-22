import 'package:flutter/material.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../practice/screens/practice_screen.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/models/ai_response.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildCurrentCourseCard(),
              const SizedBox(height: 20),
              _buildAIRecommendationCard(context),
              const SizedBox(height: 24),
              _buildSectionHeader('Today\'s Routine', '3 of 4 done'),
              const SizedBox(height: 12),
              _buildRoutineItem('Daily MCQ Challenge', 'General Knowledge • Completed', true),
              _buildRoutineItem('Bangla Literature - Ch 4', 'Ancient & Medieval era', false),
              _buildRoutineItem('English Grammar: Tense', 'Practice Set 12', false),
              const SizedBox(height: 24),
              _buildLiveTestCard(),
              const SizedBox(height: 24),
              _buildWeakTopicsCard(context),
              const SizedBox(height: 24),
              _buildSectionHeader('Explore Subjects', 'View All'),
              const SizedBox(height: 16),
              _buildSubjectsList(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Builder(
      builder: (context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: const CircleAvatar(
              radius: 18,
              backgroundColor: Color(0xFFE0F2F1),
              child: Icon(Icons.menu, color: AppColors.primary, size: 20),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Good morning,', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                const Text('Sadek', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const Icon(Icons.notifications_none, size: 24, color: AppColors.textMain),
        ],
      ),
    );
  }

  Widget _buildCurrentCourseCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9), // Very light green
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CURRENT COURSE', style: TextStyle(color: AppColors.primary, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('BCS Foundation Course', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Course Progress', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              Text('65%', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: 0.65,
            backgroundColor: Colors.white,
            borderRadius: BorderRadius.circular(10),
            minHeight: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.play_circle_fill),
            label: const Text('Resume Learning'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C), 
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAIRecommendationCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF00B074), // Primary Green for AI
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00B074).withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showNextActionSheet(context),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)),
                  child: const Icon(Icons.psychology, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('AI SYSTEM SUGGESTION', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
                      SizedBox(height: 4),
                      Text('Focus on Medieval Bengal today to boost score by 15%', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, height: 1.3)),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showNextActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FutureBuilder<AIResponse>(
        future: CoreAIService.getAIResponse('ANALYZE_PERFORMANCE', {}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingSheet();
          }
          final ai = snapshot.data!;
          return _buildRecommendationResultSheet(context, ai);
        },
      ),
    );
  }

  Widget _buildLoadingSheet() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: const Center(child: CircularProgressIndicator(color: AppColors.primary)),
    );
  }

  Widget _buildRecommendationResultSheet(BuildContext context, AIResponse ai) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Color(0xFF00B074)),
              const SizedBox(width: 12),
              const Text('Personalized Strategy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          Text(ai.headline ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(height: 12),
          Text(ai.summary ?? '', style: const TextStyle(fontSize: 14, color: AppColors.textMain, height: 1.4)),
          const SizedBox(height: 16),
          const Text('WHY THIS ACTION?', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          const SizedBox(height: 4),
          Text(ai.rationale ?? '', style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRouter.practice);
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF00695C), foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
            child: const Text('Start Recommended Practice'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(trailing, style: const TextStyle(color: AppColors.primary, fontSize: 12)),
      ],
    );
  }

  Widget _buildRoutineItem(String title, String subtitle, bool completed) {
    return Card(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: const BorderSide(color: AppColors.border)),
      child: ListTile(
        leading: Icon(completed ? Icons.check_box : Icons.check_box_outline_blank, color: completed ? AppColors.primary : AppColors.textSecondary),
        title: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        trailing: const Icon(Icons.circle, size: 8, color: Colors.green),
      ),
    );
  }

  Widget _buildLiveTestCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A237E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(color: Colors.red.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
            child: const Text('LIVE TEST', style: TextStyle(color: Colors.red, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 12),
          const Text('Weekly BCS Mock Test #12', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Join 12,400+ aspirants in the official weekly simulation.', style: TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('STARTS IN  ', style: TextStyle(color: Colors.white70, fontSize: 10)),
                Text('02 : 45 : 12', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)),
            child: const Text('Get Reminder', style: TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeakTopicsCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE1F5FE),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          const Icon(Icons.flash_on, color: AppColors.primary, size: 40),
          const SizedBox(height: 16),
          const Text('Master Weak Topics', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Our AI analyzed your last 3 tests. You\'re struggling with Mental Ability.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.wrongAnswers);
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text('Start Practice'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectsList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildSubjectItem(context, 'Bangla', Icons.book, const Color(0xFFE3F2FD)),
          _buildSubjectItem(context, 'English', Icons.translate, const Color(0xFFFFF3E0)),
          _buildSubjectItem(context, 'General Math', Icons.calculate, const Color(0xFFF3E5F5)),
        ],
      ),
    );
  }

  Widget _buildSubjectItem(BuildContext context, String name, IconData icon, Color color) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, AppRouter.subjectDetail),
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Colors.blue),
            ),
            const SizedBox(height: 16),
            Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            const Text('45 Lessons', style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNav() {
    return const AppBottomNav(currentIndex: 0);
  }
}
