import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class TopicListScreen extends StatelessWidget {
  const TopicListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Chapter Overview', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert, color: Colors.black)),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCurrentChapterCard(),
            const SizedBox(height: 32),
            _buildSectionHeader('Topics to Master', '12 Topics Total'),
            const SizedBox(height: 16),
            _buildTopicItem(context, 'Early Settlements in Bengal', 'Completed • 12/12 Lessons', Icons.check_circle, Colors.green, isCompleted: true),
            _buildTopicItem(context, 'The Pala Dynasty', '6/10 lessons', Icons.book, AppColors.primary, isCurrent: true, progress: 0.6),
            _buildTopicItem(context, 'The Sultans of Bengal', 'Not Started • 15 Lessons', Icons.lock, Colors.grey, isLocked: true),
            _buildTopicItem(context, 'The Mughal Period', 'Not Started • 22 Lessons', Icons.explore, Colors.grey, isLocked: true),
            _buildTopicItem(context, 'Medieval Architecture', 'Not Started • 8 Lessons', Icons.architecture, Colors.grey, isLocked: true),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentChapterCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF00B050),
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/carbon-fibre.png'),
          opacity: 0.1,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('CURRENT CHAPTER', style: TextStyle(color: Colors.white70, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Text('Ancient & Medieval Bengal', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: 0.45,
                  backgroundColor: Colors.white24,
                  color: Colors.white,
                  minHeight: 6,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 16),
              const Text('45% Complete', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(12)),
          child: Text(count, style: const TextStyle(color: Color(0xFF00695C), fontSize: 10, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildTopicItem(BuildContext context, String title, String subtitle, IconData icon, Color color, {bool isCompleted = false, bool isCurrent = false, bool isLocked = false, double progress = 0.0}) {
    return InkWell(
      onTap: () {
        if (!isLocked) {
          Navigator.pushNamed(context, AppRouter.lesson);
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isCurrent ? AppColors.primary : AppColors.border.withOpacity(0.5), width: isCurrent ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  if (isCurrent)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LinearProgressIndicator(value: progress, minHeight: 4, backgroundColor: AppColors.border, color: AppColors.primary),
                        const SizedBox(height: 4),
                        Text(subtitle, style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    )
                  else
                    Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.border),
          ],
        ),
      ),
    );
  }
}
