import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class ReviewSubmissionScreen extends StatelessWidget {
  const ReviewSubmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1B5E20)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Review Submission', style: TextStyle(color: Color(0xFF1B5E20), fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FINAL STEP', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
            const SizedBox(height: 12),
            const Text('45th BCS Full Length\nPreliminary Mock Test', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
            const SizedBox(height: 12),
            const Text('Please verify your progress before final submission. Once submitted, you cannot change your answers.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
            const SizedBox(height: 32),
            _buildStatsCard(),
            const SizedBox(height: 32),
            _buildImportantInfo(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.testResult),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFF00A76F),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Submit Test Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(width: 12), Icon(Icons.send, size: 20)]),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFFE0F2F1),
                foregroundColor: const Color(0xFF1B5E20),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.history, size: 20), SizedBox(width: 12), Text('Go Back & Review', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))]),
      child: Column(
        children: [
          const Text('TOTAL QUESTIONS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5)),
          const SizedBox(height: 8),
          const Text('200', style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(child: _buildMiniStat('186', 'ATTEMPTED', Colors.green)),
              Expanded(child: _buildMiniStat('10', 'SKIPPED', Colors.red)),
              Expanded(child: _buildMiniStat('4', 'REVIEW', Colors.blue)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniStat(String value, String label, Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
        ],
      ),
    );
  }

  Widget _buildImportantInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFFFFDE7), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.orange.withOpacity(0.1))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.warning, color: Colors.orange, size: 20)),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Important Information', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF5D4037))),
                SizedBox(height: 4),
                Text('You have 10 unattempted questions. Unanswered questions will receive 0 marks.', style: TextStyle(fontSize: 11, color: Color(0xFF5D4037), height: 1.5)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border, width: 0.5))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.assignment_ind, 'EXAM', true),
          _buildNavItem(Icons.analytics_outlined, 'ANALYSIS', false),
          _buildNavItem(Icons.bookmark_outline, 'BOOKMARKS', false),
          _buildNavItem(Icons.person_outline, 'PROFILE', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: isActive ? BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF1B5E20) : AppColors.textSecondary, size: 20),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF1B5E20) : AppColors.textSecondary)),
        ],
      ),
    );
  }
}
