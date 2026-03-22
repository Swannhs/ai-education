import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class LiveTestScreen extends StatelessWidget {
  const LiveTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _buildAppBarTitle(),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProgressCard(),
            const SizedBox(height: 16),
            _buildMetaInfoRow(),
            const SizedBox(height: 24),
            _buildQuestionCard(),
            const SizedBox(height: 24),
            _buildOptionsList(),
            const SizedBox(height: 40),
            _buildJumpToQuestionSection(),
            const SizedBox(height: 32),
            _buildExamTipBox(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      children: [
        const Icon(Icons.security, color: Color(0xFF00695C), size: 20),
        const SizedBox(width: 8),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Competitive Exam -', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
              Text('Session A', style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(20)),
          child: const Row(
            children: [
              Text('14 / 200', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
              SizedBox(width: 8),
              Icon(Icons.timer_outlined, color: Colors.blue, size: 14),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF1F8E9), borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('QUESTION PROGRESS', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
              Text('14 of 200', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: 0.07, backgroundColor: Colors.white, color: const Color(0xFF00B050), minHeight: 4, borderRadius: BorderRadius.circular(2)),
        ],
      ),
    );
  }

  Widget _buildMetaInfoRow() {
    return Wrap(
      spacing: 8,
      children: [
        _buildMetaChip('Subject: Constitutional Law', Icons.book, Colors.green),
        _buildMetaChip('Difficulty: Medium', Icons.signal_cellular_alt, Colors.orange),
        _buildMetaChip('+2.0 / -0.5', Icons.control_point_duplicate, Colors.blue),
      ],
    );
  }

  Widget _buildMetaChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.05), borderRadius: BorderRadius.circular(6), border: Border.all(color: color.withOpacity(0.1))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 12),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('QUESTION 14', style: TextStyle(color: Color(0xFF00B050), fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
          SizedBox(height: 16),
          Text(
            'Which of the following is considered the primary source and supreme law of the People\'s Republic of Bangladesh?',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.4),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionsList() {
    return Column(
      children: [
        _buildOptionTile('A', 'The Proclamation of Independence'),
        _buildOptionTile('B', 'The Constitution of Bangladesh', isSelected: true),
        _buildOptionTile('C', 'The Penal Code 1860'),
        _buildOptionTile('D', 'The Code of Civil Procedure'),
      ],
    );
  }

  Widget _buildOptionTile(String label, String text, {bool isSelected = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFF1F8E9) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isSelected ? const Color(0xFF00B050) : AppColors.border.withOpacity(0.5), width: isSelected ? 1.5 : 1),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: isSelected ? const Color(0xFF00695C) : const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(8)),
            child: Text(label, style: TextStyle(color: isSelected ? Colors.white : AppColors.textMain, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w500))),
          if (isSelected) const Icon(Icons.check_circle, color: Color(0xFF00B050)),
        ],
      ),
    );
  }

  Widget _buildJumpToQuestionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('JUMP TO QUESTION', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.0)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 5,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          children: [
            _buildQuestionGridTile('14', isActive: true),
            _buildQuestionGridTile('15'),
            _buildQuestionGridTile('16'),
            _buildQuestionGridTile('17'),
            _buildQuestionGridTile('18'),
            _buildQuestionGridTile('19'),
            _buildQuestionGridTile('20'),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildLegendItem('ACTIVE', const Color(0xFF00695C)),
            const SizedBox(width: 24),
            _buildLegendItem('UNVISITED', const Color(0xFFE3F2FD)),
          ],
        ),
      ],
    );
  }

  Widget _buildQuestionGridTile(String label, {bool isActive = false}) {
    return Container(
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFF00695C) : const Color(0xFFE3F2FD),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(label, style: TextStyle(color: isActive ? Colors.white : AppColors.textSecondary, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Icon(Icons.circle, color: color, size: 8),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildExamTipBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF00B050),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.white, size: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
                child: const Text('EXAM TIP', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Negative marking applies to this session. Skip questions if you are uncertain to protect your score.',
            style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBottomAction(Icons.arrow_back, 'PREVIOUS'),
          _buildBottomAction(Icons.bookmark_border, 'MARK'),
          _buildBottomAction(Icons.arrow_forward, 'NEXT'),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.practiceResult); // Should lead to test result
            },
            icon: const Icon(Icons.check_circle, size: 18),
            label: const Text('SUBMIT'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: AppColors.textSecondary, size: 20),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 8, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
