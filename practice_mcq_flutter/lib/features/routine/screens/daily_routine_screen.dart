import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';
import '../../../shared/widgets/app_drawer.dart';
import '../../../core/routing/app_router.dart';

class DailyRoutineScreen extends StatelessWidget {
  const DailyRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: const Text('BCS Prep Pro', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
        actions: [
          const Icon(Icons.notifications_none),
          const SizedBox(width: 8),
          const CircleAvatar(radius: 12, child: Icon(Icons.person, size: 12)),
          const SizedBox(width: 16),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('STUDY PLAN', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
            const Text('Daily Routine', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildCalendarStrip(),
            const SizedBox(height: 24),
            Row(
              children: [
                _buildStatDisplay('65%', 'Daily Goal Met', Icons.trending_up, Colors.green),
                const SizedBox(width: 16),
                _buildStatDisplay('4.2h', 'Study Session', Icons.timer, Colors.blue),
              ],
            ),
            const SizedBox(height: 24),
            _buildAITutorAnalysisCard(),
            const SizedBox(height: 32),
            _buildSectionHeader('Today\'s Tasks', '3 / 5 Done'),
            const SizedBox(height: 16),
            _buildTaskItem(context, 'Bengali Literature: Medieval Age', 'Lesson • 45 mins', true, 
              onTap: () => Navigator.pushNamed(context, AppRouter.lessonContentViewer)),
            _buildTaskItem(context, 'General Science: Physics Basics', 'Lesson • 60 mins', true,
              onTap: () => Navigator.pushNamed(context, AppRouter.lessonContentViewer)),
            _buildTaskItem(context, 'Daily Mock Test: English Grammar', 'Quiz • 30 mins • Mandatory', false, hasStart: true,
              onTap: () => Navigator.pushNamed(context, AppRouter.testDetail)),
            _buildTaskItem(context, 'Mathematics: Geometry Part 1', 'Lesson • 90 mins', false,
              onTap: () => Navigator.pushNamed(context, AppRouter.lessonContentViewer)),
            _buildTaskItem(context, 'Current Affairs: International', 'Reading • 20 mins', false,
              onTap: () => Navigator.pushNamed(context, AppRouter.lessonContentViewer)),
            const SizedBox(height: 24),
            _buildAddCustomTaskButton(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00695C),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCalendarStrip() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('September 2024', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  const Icon(Icons.chevron_left, size: 16),
                  const SizedBox(width: 16),
                  const Icon(Icons.chevron_right, size: 16),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDayItem('MON', '11', false),
              _buildDayItem('TUE', '12', false),
              _buildDayItem('WED', '13', true),
              _buildDayItem('THU', '14', false),
              _buildDayItem('FRI', '15', false),
              _buildDayItem('SAT', '16', false),
              _buildDayItem('SUN', '17', false),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDayItem(String day, String date, bool isSelected) {
    return Column(
      children: [
        Text(day, style: TextStyle(fontSize: 10, color: isSelected ? AppColors.primary : AppColors.textSecondary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            date,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : AppColors.textMain,
            ),
          ),
        ),
        if (isSelected) Container(margin: const EdgeInsets.only(top: 4), width: 4, height: 4, decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle)),
      ],
    );
  }

  Widget _buildStatDisplay(String val, String label, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
          boxShadow: [BoxShadow(color: color.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(height: 12),
            Text(val, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildAITutorAnalysisCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00B050),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.psychology, color: Colors.white)),
              const SizedBox(width: 12),
              const Text('AI TUTOR ANALYSIS', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          const Text('Complete 3 Math topics today to stay on track.', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(
            'Based on your recent performance, you need more practice in Geometry and Algebra to hit your Batch 45 target.',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(trailing, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }

  Widget _buildTaskItem(
    BuildContext context, 
    String title, 
    String subtitle, 
    bool isCompleted, {
    bool hasStart = false,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined, color: isCompleted ? AppColors.primary : AppColors.textSecondary),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, decoration: isCompleted ? TextDecoration.lineThrough : null)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            if (hasStart)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
                child: const Text('Start', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 12)),
              )
            else
              const Icon(Icons.drag_indicator, color: AppColors.border),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCustomTaskButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border, style: BorderStyle.none), // Should be dashed in real implementation
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.add_circle_outline, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 8),
          const Text('Add custom task', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return const AppBottomNav(currentIndex: 2);
  }
}
