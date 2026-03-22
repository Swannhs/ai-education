import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class TestDetailScreen extends StatefulWidget {
  const TestDetailScreen({super.key});

  @override
  State<TestDetailScreen> createState() => _TestDetailScreenState();
}

class _TestDetailScreenState extends State<TestDetailScreen> {
  bool _isUnderstood = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('BCS Preliminary Mock Test', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        centerTitle: true,
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
            _buildMainInfoCard(),
            const SizedBox(height: 20),
            _buildAISmartTip(),
            const SizedBox(height: 24),
            _buildGridDetails(),
            const SizedBox(height: 16),
            _buildQuestionCountBox(),
            const SizedBox(height: 32),
            _buildSectionTitle('Syllabus & Topics'),
            const SizedBox(height: 16),
            _buildSyllabusChips(),
            const SizedBox(height: 32),
            _buildSectionTitle('Exam Instructions'),
            const SizedBox(height: 16),
            _buildInstructionItem('01.', 'Ensure a stable internet connection throughout the 120-minute session. Disconnection may result in auto-submission.'),
            _buildInstructionItem('02.', 'No calculators, mobile phones, or smart devices are allowed to be used during the test.'),
            _buildInstructionItem('03.', '0.50 marks will be deducted for each incorrect answer. Skip questions if you are unsure.'),
            _buildInstructionItem('04.', 'The test will automatically end once the timer reaches zero. You cannot pause the live test.'),
            const SizedBox(height: 40),
            Row(
              children: [
                Checkbox(
                  value: _isUnderstood,
                  activeColor: AppColors.primary,
                  onChanged: (val) => setState(() => _isUnderstood = val ?? false),
                ),
                const Expanded(
                  child: Text('I have read and understood all the instructions.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isUnderstood ? () {
                Navigator.pushNamed(context, AppRouter.liveTest);
              } : null,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Start Mock Test'),
                  SizedBox(width: 8),
                  Icon(Icons.play_arrow, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildTag('MOCK TEST #32', const Color(0xFFE0F2F1), const Color(0xFF00695C)),
              const SizedBox(width: 8),
              _buildTag('PRELIMINARY', const Color(0xFFE3F2FD), Colors.blue),
            ],
          ),
          const SizedBox(height: 20),
          const Text('45th BCS Full Length Preliminary Model Test', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.3)),
          const SizedBox(height: 12),
          const Text('Category: Bangladesh Civil Service (BCS) General', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
        ],
      ),
    );
  }

  Widget _buildTag(String label, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: textColor, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildAISmartTip() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(16)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(color: Color(0xFF00B050), shape: BoxShape.circle),
            child: const Icon(Icons.flash_on, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AI SMART TIP', style: TextStyle(color: Color(0xFF00695C), fontSize: 10, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Text(
                  'AI suggests reviewing Narration and Proverbs before attempting this test based on your recent performance.',
                  style: TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridDetails() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 2.2,
      children: [
        _buildInfoTile('LIVE DATE', 'May 24, 10:00 AM', Icons.calendar_today_outlined, Colors.green),
        _buildInfoTile('DURATION', '120 Minutes', Icons.timer_outlined, Colors.blue),
        _buildInfoTile('TOTAL MARKS', '200 Marks', Icons.emoji_events_outlined, Colors.orange),
        _buildInfoTile('NEG. MARKING', '0.50 per wrong', Icons.error_outline, Colors.red),
      ],
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCountBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(8)),
            child: const Icon(Icons.assignment_outlined, color: Colors.blue),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('QUESTION COUNT', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
              Text('200 Questions (MCQ)', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(width: 4, height: 18, decoration: BoxDecoration(color: const Color(0xFF00B050), borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 12),
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildSyllabusChips() {
    final topics = ['Bangla Language', 'English Literature', 'Bangladesh Affairs', 'International Affairs', 'Mental Ability', 'General Science'];
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: topics.map((t) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(10)),
        child: Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textMain)),
      )).toList(),
    );
  }

  Widget _buildInstructionItem(String num, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(num, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xFF00B050))),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textMain, height: 1.5)),
          ),
        ],
      ),
    );
  }
}
