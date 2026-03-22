import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/routing/app_router.dart';
import '../providers/learn_provider.dart';
import '../../domain/learn_models.dart';

class TopicListScreen extends ConsumerWidget {
  final String chapterId;
  const TopicListScreen({super.key, this.chapterId = 'c1'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topicsAsync = ref.watch(topicsProvider(chapterId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Chapter Overview', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: topicsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (topics) => SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildCurrentChapterCard(),
              const SizedBox(height: 32),
              _buildSectionHeader('Topics to Master', '${topics.length} Topics Total'),
              const SizedBox(height: 16),
              ...topics.map((topic) => _buildTopicItem(context, topic)),
            ],
          ),
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

  Widget _buildTopicItem(BuildContext context, Topic topic) {
    final bool isCompleted = topic.status == TopicStatus.completed;
    final bool isCurrent = topic.status == TopicStatus.inProgress;
    
    IconData icon = Icons.book;
    Color color = AppColors.primary;
    
    if (isCompleted) {
      icon = Icons.check_circle;
      color = Colors.green;
    } else if (isCurrent) {
      icon = Icons.play_circle_fill;
      color = AppColors.primary;
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.lesson, arguments: topic.id);
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
                  Text(topic.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 4),
                  Text('${topic.lessonCount} Lessons • ${topic.status.name}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
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
