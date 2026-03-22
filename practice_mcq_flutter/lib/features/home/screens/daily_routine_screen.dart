import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class DailyRoutineScreen extends StatelessWidget {
  const DailyRoutineScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.black),
        title: const Text('BCS Prep Pro', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold)),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
          CircleAvatar(radius: 16, backgroundColor: Color(0xFF00B074), child: Text('SA', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
          SizedBox(width: 16),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('STUDY PLAN', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 8),
            const Text('Daily Routine', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildCalendar(),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildStatCard('65%', 'Daily Goal Met', Icons.trending_up, Colors.green)),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard('4.2h', 'Study Session', Icons.timer_outlined, Colors.blue)),
              ],
            ),
            const SizedBox(height: 24),
            _buildAITutorCard(),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Today\'s Tasks', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Text('3 / 5 Done', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 16),
            _buildTaskItem('Bengali Literature: Medieval Age', 'Lesson • 45 mins', true),
            _buildTaskItem('General Science: Physics Basics', 'Lesson • 60 mins', true),
            _buildTaskItem('Daily Mock Test: English Grammar', 'Quiz • 30 mins • Mandatory', false, showStart: true),
            _buildTaskItem('Mathematics: Geometry Part 1', 'Lesson • 90 mins', false),
            _buildTaskItem('Current Affairs: International', 'Reading • 20 mins', false),
            const SizedBox(height: 16),
            _buildAddCustomTask(),
            const SizedBox(height: 32),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF00695C),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 2), // Routine tab
    );
  }

  Widget _buildCalendar() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(24)),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('September 2024', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Row(
                children: [
                  Icon(Icons.chevron_left, size: 20),
                  SizedBox(width: 16),
                  Icon(Icons.chevron_right, size: 20),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildCalendarDay('MON', '11'),
              _buildCalendarDay('TUE', '12'),
              _buildCalendarDay('WED', '13', isActive: true),
              _buildCalendarDay('THU', '14'),
              _buildCalendarDay('FRI', '15'),
              _buildCalendarDay('SAT', '16'),
              _buildCalendarDay('SUN', '17'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarDay(String day, String date, {bool isActive = false}) {
    return Column(
      children: [
        Text(day, style: const TextStyle(fontSize: 9, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFF00695C) : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(date, style: TextStyle(color: isActive ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 13)),
          ),
        ),
        if (isActive) const Padding(padding: EdgeInsets.only(top: 4), child: Icon(Icons.circle, size: 4, color: Color(0xFF00695C))),
      ],
    );
  }

  Widget _buildStatCard(String value, String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border(left: BorderSide(color: color, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _buildAITutorCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: const Color(0xFF00B074), borderRadius: BorderRadius.circular(24)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.psychology_outlined, color: Colors.white, size: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('AI TUTOR ANALYSIS', style: TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                const SizedBox(height: 8),
                const Text('Complete 3 Math topics today to stay on track.', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, height: 1.3)),
                const SizedBox(height: 8),
                const Text('Based on your recent performance, you need more practice in Geometry and Algebra to hit your Batch 45 target.', style: TextStyle(color: Colors.white70, fontSize: 12, height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String title, String subtitle, bool isDone, {bool showStart = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Icon(isDone ? Icons.check_circle : Icons.circle_outlined, color: isDone ? const Color(0xFF1B5E20) : AppColors.textSecondary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: isDone ? AppColors.textSecondary : Colors.black87, decoration: isDone ? TextDecoration.lineThrough : null)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
              ],
            ),
          ),
          if (showStart)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(8)),
              child: const Text('Start', style: TextStyle(color: Color(0xFF1B5E20), fontSize: 11, fontWeight: FontWeight.bold)),
            )
          else
            const Icon(Icons.drag_indicator, color: AppColors.border, size: 20),
        ],
      ),
    );
  }

  Widget _buildAddCustomTask() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border, style: BorderStyle.none)), // Dotted border alternative
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_circle_outline, color: AppColors.textSecondary, size: 18),
          SizedBox(width: 8),
          Text('Add custom task', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
