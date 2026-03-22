import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/services/ai_service.dart';
import '../../../../core/models/ai_response.dart';
import '../providers/learn_provider.dart';
import '../../domain/learn_models.dart';

class LessonContentViewerScreen extends ConsumerStatefulWidget {
  final String topicId;

  const LessonContentViewerScreen({
    super.key,
    this.topicId = 't1',
  });

  @override
  ConsumerState<LessonContentViewerScreen> createState() => _LessonContentViewerScreenState();
}

class _LessonContentViewerScreenState extends ConsumerState<LessonContentViewerScreen> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    final lessonAsync = ref.watch(lessonProvider(widget.topicId));

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: lessonAsync.when(
          data: (lesson) => Text(lesson.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Error'),
        ),
        actions: [
          IconButton(
            onPressed: () => setState(() => isBookmarked = !isBookmarked),
            icon: Icon(isBookmarked ? Icons.bookmark : Icons.bookmark_border, color: isBookmarked ? AppColors.primary : null),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: lessonAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (lesson) => Column(
          children: [
            _buildPrimaryContent(lesson),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContentHeader(lesson),
                    const SizedBox(height: 24),
                    _buildLessonDescription(lesson),
                    const SizedBox(height: 32),
                    if (lesson.resources != null) _buildRelatedMaterials(lesson.resources!),
                    const SizedBox(height: 32),
                    _buildAIExplanationShortcut(context, lesson),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildPrimaryContent(Lesson lesson) {
     // Default to a placeholder video style for now if it's text
     return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
            ),
          ),
        );
  }

  Widget _buildContentHeader(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTag('Standard', Colors.blue),
            const SizedBox(width: 8),
            _buildTag('15 mins', Colors.grey),
          ],
        ),
        const SizedBox(height: 16),
        Text(lesson.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Instructor: Sadek Rahman', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
      ],
    );
  }

  Widget _buildTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildLessonDescription(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Key Learning Points', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 12),
        Text(
          lesson.content,
          style: const TextStyle(color: AppColors.textMain, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildRelatedMaterials(List<LessonResource> resources) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Related Materials', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        ...resources.map((res) => _buildMaterialItem(res.label, _getResourceIcon(res.type), _getResourceColor(res.type))),
      ],
    );
  }
  
  IconData _getResourceIcon(String type) {
    if (type == 'pdf') return Icons.insert_drive_file;
    if (type == 'video') return Icons.play_circle;
    return Icons.attachment;
  }
  
  Color _getResourceColor(String type) {
    if (type == 'pdf') return Colors.red;
    if (type == 'video') return Colors.blue;
    return Colors.grey;
  }

  Widget _buildMaterialItem(String title, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          const Spacer(),
          const Icon(Icons.download_for_offline_outlined, color: Colors.grey, size: 20),
        ],
      ),
    );
  }

  Widget _buildAIExplanationShortcut(BuildContext context, Lesson lesson) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFF1F8E9), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.primary),
          const SizedBox(width: 16),
          const Expanded(
            child: Text('Stuck on a concept? Ask our AI Tutor for a simplified explanation.', style: TextStyle(fontSize: 12, color: AppColors.textMain)),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => _showSimplifySheet(context, lesson.id),
            child: const Text('Ask AI', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void _showSimplifySheet(BuildContext context, String lessonId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FutureBuilder<AIResponse>(
        future: CoreAIService.getAIResponse(CoreAIService.simplifyLesson(lessonId, 'standard_explanation')),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingSheet();
          }
          final ai = snapshot.data!;
          return _buildSimplifyResultSheet(context, ai);
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

  Widget _buildSimplifyResultSheet(BuildContext context, AIResponse ai) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.blue),
              const SizedBox(width: 12),
              Text(ai.responseTitle ?? 'Simplified Explanation', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 20),
          Text(ai.content ?? '', style: const TextStyle(fontSize: 15, height: 1.5)),
          const SizedBox(height: 20),
          if (ai.bulletPoints != null)
            ...ai.bulletPoints!.map((p) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                      Expanded(child: Text(p, style: const TextStyle(fontSize: 14))),
                    ],
                  ),
                )),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.amber.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Text('💡 TIP: ${ai.memoryTip}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, minimumSize: const Size(double.infinity, 50)),
            child: const Text('I Understand'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00695C),
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: const Text('Mark as Completed', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
