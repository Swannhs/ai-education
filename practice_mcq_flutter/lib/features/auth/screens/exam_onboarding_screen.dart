import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class ExamOnboardingScreen extends StatefulWidget {
  const ExamOnboardingScreen({super.key});

  @override
  State<ExamOnboardingScreen> createState() => _ExamOnboardingScreenState();
}

class _ExamOnboardingScreenState extends State<ExamOnboardingScreen> {
  String selectedExam = 'BCS';
  String selectedProficiency = 'Beginner';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('GovPrep BD', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Text('Step 1 of 2', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2, color: Colors.black),
                children: [
                  TextSpan(text: 'What are you '),
                  TextSpan(text: 'preparing', style: TextStyle(color: Color(0xFF00B074))),
                  TextSpan(text: '\nfor?'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const Text('Select your target exam to personalize your study plan.', style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
            const SizedBox(height: 48),
            const Text('TARGET EXAMINATION', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5)),
            const SizedBox(height: 16),
            _buildExamOption('BCS', 'Bangladesh Civil Service', Icons.account_balance_outlined),
            _buildExamOption('Bank Jobs', 'Govt & Private Banks', Icons.business_outlined),
            _buildExamOption('NTRCA', 'Teacher Registration', Icons.school_outlined),
            _buildExamOption('Primary Teacher', 'Govt Primary Schools', Icons.info_outline),
            const SizedBox(height: 48),
            const Text('CURRENT PROFICIENCY', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 0.5)),
            const SizedBox(height: 16),
            _buildProficiencySelector(),
            const SizedBox(height: 48),
            _buildInfoBox(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.home),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFF00B074),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Continue', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), SizedBox(width: 8), Icon(Icons.arrow_forward, size: 20)]),
            ),
            const SizedBox(height: 24),
            const Center(child: Text('By continuing, you agree to our Terms of Service.', style: TextStyle(color: AppColors.textSecondary, fontSize: 10))),
            const SizedBox(height: 40),
          ],
        ),
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
          border: isSelected ? Border.all(color: const Color(0xFF00B074), width: 1.5) : Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFF00B074), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: Colors.white, size: 20)),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                ],
              ),
            ),
            Icon(isSelected ? Icons.radio_button_checked : Icons.radio_button_off, color: isSelected ? const Color(0xFF00B074) : AppColors.border),
          ],
        ),
      ),
    );
  }

  Widget _buildProficiencySelector() {
    final levels = ['Beginner', 'Intermediate', 'Advanced'];
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: levels.map((l) => Expanded(child: GestureDetector(
          onTap: () => setState(() => selectedProficiency = l),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: selectedProficiency == l ? Colors.white : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: selectedProficiency == l ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4)] : null,
            ),
            child: Center(child: Text(l, style: TextStyle(color: selectedProficiency == l ? const Color(0xFF006951) : AppColors.textSecondary, fontWeight: FontWeight.bold, fontSize: 13))),
          ),
        ))).toList(),
      ),
    );
  }

  Widget _buildInfoBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: Color(0xFF00B074), size: 20),
          const SizedBox(width: 16),
          const Expanded(
            child: Text(
              'Choosing the right path helps our AI tutor focus on high-yield topics specific to your syllabus. You can change this later in settings.',
              style: TextStyle(color: Color(0xFF004D40), fontSize: 12, height: 1.5, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
