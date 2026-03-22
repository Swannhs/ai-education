import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../../../shared/widgets/app_bottom_nav.dart';

class SubjectDetailScreen extends StatelessWidget {
  const SubjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Subject Detail', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubjectHeader(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCourseContent(context),
                  const SizedBox(height: 32),
                  _buildSectionHeader('Available PDFs', 'View All'),
                  const SizedBox(height: 16),
                  _buildPDFItem('Bangla Literature Lecture Notes', '2.4 MB • PDF'),
                  _buildPDFItem('Ancient History Summary', '1.8 MB • PDF'),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  Widget _buildSubjectHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, border: Border(bottom: BorderSide(color: AppColors.border))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.book, color: AppColors.primary, size: 32)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Bangla', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Text('12 Chapters • 120 Lessons', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Course Progress', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              Text('45%', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.45, backgroundColor: AppColors.border, color: AppColors.primary, minHeight: 6, borderRadius: BorderRadius.circular(3)),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String trailing) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(trailing, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildCourseContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Course Content', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _buildChapterItem(context, '1. Ancient & Medieval Bengal', '45% Complete', true),
        _buildChapterItem(context, '2. British Period', 'Not started', false),
        _buildChapterItem(context, '3. Pakistan Period', 'Not started', false),
        _buildChapterItem(context, '4. Liberation War', 'Not started', false),
      ],
    );
  }

  Widget _buildChapterItem(BuildContext context, String title, String progress, bool isActive) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, AppRouter.topicList);
      },
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: isActive ? const Color(0xFFE8F5E9) : AppColors.background, borderRadius: BorderRadius.circular(8)),
        child: Icon(isActive ? Icons.play_circle_fill : Icons.lock_outline, color: isActive ? AppColors.primary : Colors.grey),
      ),
      title: Text(title, style: TextStyle(fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
      subtitle: Text(progress, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right, size: 20),
    );
  }

  Widget _buildPDFItem(String title, String subtitle) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Row(
        children: [
          const Icon(Icons.picture_as_pdf, color: Colors.red),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.download, color: AppColors.primary, size: 20),
        ],
      ),
    );
  }
}
