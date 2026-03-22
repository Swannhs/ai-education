import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class ExamPreferencesScreen extends ConsumerStatefulWidget {
  const ExamPreferencesScreen({super.key});

  @override
  ConsumerState<ExamPreferencesScreen> createState() => _ExamPreferencesScreenState();
}

class _ExamPreferencesScreenState extends ConsumerState<ExamPreferencesScreen> {
  String selectedExam = 'BCS';
  String selectedLevel = 'Intermediate';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFF00B050), borderRadius: BorderRadius.circular(16)), child: const Icon(Icons.rocket_launch, color: Colors.white, size: 32)),
              const SizedBox(height: 32),
              const Text('Personalize Your Prep', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              const Text('Help us tailor your learning experience by selecting your target goal and current expertise level.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
              const SizedBox(height: 48),
              _buildSectionTitle('Target Exam', 'REQUIRED'),
              _buildExamOption('BCS', 'Bangladesh Civil Service Examination', Icons.account_balance_outlined),
              _buildExamOption('Bank', 'Government & Private Bank Job Exams', Icons.business_outlined),
              _buildExamOption('NTRCA', 'Non-Govt. Teacher Registration', Icons.school_outlined),
              _buildExamOption('Primary', 'Primary Teacher Recruitment', Icons.info_outline),
              const SizedBox(height: 48),
              _buildSectionTitle('Knowledge Level', ''),
              _buildLevelOption('Beginner', 'Starting from the basics', Icons.star_border),
              _buildLevelOption('Intermediate', 'Familiar with major topics', Icons.trending_up),
              _buildLevelOption('Advanced', 'Focus on complex analysis', Icons.workspace_premium_outlined),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).completeExamPreferences();
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRouter.home);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: const Color(0xFF006951),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 4,
                ),
                child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Continue to Dashboard', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 20)]),
              ),
              const SizedBox(height: 24),
              const Text('Step 1 of 1: Goal Setting', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          if (label.isNotEmpty) Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary, letterSpacing: 1.0, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildExamOption(String title, String subtitle, IconData icon) {
    bool isSelected = selectedExam == title;
    return GestureDetector(
      onTap: () => setState(() => selectedExam = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isSelected ? const Color(0xFF006951) : AppColors.border.withOpacity(0.5), width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: const Color(0xFF0D47A1), size: 20)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelOption(String title, String subtitle, IconData icon) {
    bool isSelected = selectedLevel == title;
    return GestureDetector(
      onTap: () => setState(() => selectedLevel = title),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : const Color(0xFFF0F7FF),
          borderRadius: BorderRadius.circular(12),
          border: isSelected ? Border.all(color: const Color(0xFF006951), width: 1.5) : null,
        ),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: isSelected ? const Color(0xFF006951) : const Color(0xFF00B050), size: 20)),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
