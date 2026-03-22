import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LessonContentViewerScreen extends StatefulWidget {
  final String title;
  final String contentType; // 'video', 'pdf', 'audio', 'text'

  const LessonContentViewerScreen({
    super.key,
    this.title = 'Algebraic Formulas',
    this.contentType = 'video',
  });

  @override
  State<LessonContentViewerScreen> createState() => _LessonContentViewerScreenState();
}

class _LessonContentViewerScreenState extends State<LessonContentViewerScreen> {
  bool isBookmarked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
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
      body: Column(
        children: [
          _buildPrimaryContent(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildContentHeader(),
                  const SizedBox(height: 24),
                  _buildLessonDescription(),
                  const SizedBox(height: 32),
                  _buildRelatedMaterials(),
                  const SizedBox(height: 32),
                  _buildAIExplanationShortcut(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomAction(),
    );
  }

  Widget _buildPrimaryContent() {
    switch (widget.contentType) {
      case 'video':
        return AspectRatio(
          aspectRatio: 16 / 9,
          child: Container(
            color: Colors.black,
            child: const Center(
              child: Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
            ),
          ),
        );
      case 'pdf':
        return Container(
          height: 200,
          width: double.infinity,
          color: const Color(0xFFF5F5F5),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.picture_as_pdf, color: Colors.red, size: 48),
              SizedBox(height: 12),
              Text('PDF Preview Mode', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        );
      case 'audio':
        return Container(
          height: 120,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF004D40), Color(0xFF00796B)]),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.graphic_eq, color: Colors.white, size: 40),
              SizedBox(height: 8),
              Text('Playing Audio Lesson...', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildContentHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTag('Advanced', Colors.blue),
            const SizedBox(width: 8),
            _buildTag('15 mins', Colors.grey),
          ],
        ),
        const SizedBox(height: 16),
        Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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

  Widget _buildLessonDescription() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Key Learning Points', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 12),
        Text(
          '• Introduction to basic formulas.\n'
          '• Shortcut methods for large multiplications.\n'
          '• Application of (a+b)^2 in competitive exams.\n'
          '• Solving 5 previous years\' questions.',
          style: TextStyle(color: AppColors.textMain, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildRelatedMaterials() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Related Materials', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 16),
        _buildMaterialItem('Lecture Note.pdf', Icons.insert_drive_file, Colors.blue),
        _buildMaterialItem('Quick Revision.mp3', Icons.mic, Colors.orange),
        _buildMaterialItem('Practice Questions', Icons.quiz, Colors.green),
      ],
    );
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

  Widget _buildAIExplanationShortcut() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F8E9),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: AppColors.primary),
          const SizedBox(width: 16),
          const Expanded(
            child: Text('Stuck on a concept? Ask our AI Tutor for a simplified explanation.', style: TextStyle(fontSize: 12, color: AppColors.textMain)),
          ),
          const SizedBox(width: 8),
          TextButton(onPressed: () {}, child: const Text('Ask AI', style: TextStyle(fontWeight: FontWeight.bold))),
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
