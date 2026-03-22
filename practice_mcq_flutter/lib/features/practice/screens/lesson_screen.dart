import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LessonScreen extends StatelessWidget {
  const LessonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Constitutional Law: Part I', style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined, color: Colors.black)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border, color: Colors.black)),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildVideoPlayerMock(),
            const SizedBox(height: 16),
            _buildAIActionRow(),
            const SizedBox(height: 24),
            _buildLessonContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoPlayerMock() {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1589829545856-d10d557cf95f?auto=format&fit=crop&q=80&w=800'),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Center(
        child: Container(
          width: 60, height: 60,
          decoration: const BoxDecoration(color: Color(0xFF00B050), shape: BoxShape.circle),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
        ),
      ),
    );
  }

  Widget _buildAIActionRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          _buildAIButton('Explain', Icons.lightbulb_outline, Colors.blue),
          const SizedBox(width: 12),
          _buildAIButton('Ask AI', Icons.psychology_outlined, Colors.purple),
          const SizedBox(width: 12),
          _buildAIButton('Simplify', Icons.auto_awesome_outlined, Colors.green),
        ],
      ),
    );
  }

  Widget _buildAIButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildLessonContent() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(6)),
            child: const Text('UNIT 1.1', style: TextStyle(color: Color(0xFF00695C), fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          const Text('Historical Background of the Constitution', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, height: 1.3)),
          const SizedBox(height: 24),
          const Text(
            'The Constitution of the People\'s Republic of Bangladesh is the supreme law of Bangladesh. It was adopted on 4 November 1972 and came into effect on 16 December 1972, marking the first anniversary of the country\'s victory in the Liberation War.',
            style: TextStyle(color: AppColors.textMain, height: 1.6, fontSize: 15),
          ),
          const SizedBox(height: 24),
          _buildKeyFactBox('The Constitution declares Bangladesh to be a secular, democratic republic where sovereignty belongs to the people.'),
          const SizedBox(height: 32),
          const Text('Fundamental Principles', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          _buildBulletPoint('Nationalism'),
          _buildBulletPoint('Socialism'),
          _buildBulletPoint('Democracy'),
          _buildBulletPoint('Secularism'),
          const SizedBox(height: 24),
          const Text(
            'Understanding these principles is crucial for any competitive government exam as they form the bedrock of the administrative and judicial structure of the nation.',
            style: TextStyle(color: AppColors.textMain, height: 1.6, fontSize: 15),
          ),
          const SizedBox(height: 48),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.check_circle, size: 20),
            label: const Text('Mark as Complete'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 56),
              foregroundColor: const Color(0xFF00695C),
              side: const BorderSide(color: Color(0xFF00695C)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            child: const Text('Next Lesson'),
          ),
        ],
      ),
    );
  }

  Widget _buildKeyFactBox(String text) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F7FF),
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: Colors.blue, width: 4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Key Fact:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.blue)),
          const SizedBox(height: 8),
          Text(text, style: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.textMain, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 6, color: Colors.green),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
