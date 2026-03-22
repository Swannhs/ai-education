import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMetadataChips(),
              const SizedBox(height: 24),
              _buildQuestionCard(),
              const SizedBox(height: 32),
              _buildOptionTile('A', 'Scarce', false, false),
              _buildOptionTile('B', 'Plentiful', true, true), // Selected Correct
              _buildOptionTile('C', 'Rare', false, false),
              _buildOptionTile('D', 'Sparse', false, false),
              const SizedBox(height: 40),
              _buildAIAssistantGrid(),
              const SizedBox(height: 40),
              PrimaryButton(text: 'Next Question', onPressed: () {}),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(Icons.timer_outlined, color: AppColors.primary),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Question', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          RichText(
            text: const TextSpan(
              text: '14',
              style: TextStyle(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 18),
              children: [
                TextSpan(text: '/50', style: TextStyle(color: AppColors.textSecondary, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(20)),
          child: const Row(
            children: [
              Icon(Icons.timer, size: 16, color: AppColors.primary),
              SizedBox(width: 4),
              Text('12:45', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Finish', style: TextStyle(color: Colors.grey))),
      ],
    );
  }

  Widget _buildMetadataChips() {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildChip('SUBJECT: ENGLISH', const Color(0xFFE3F2FD)),
        _buildChip('TOPIC: SYNONYMS', const Color(0xFFE3F2FD)),
        _buildChip('DIFFICULTY: MEDIUM', const Color(0xFFE8EAF6)),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
      child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
    );
  }

  Widget _buildQuestionCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: const Text(
        'Which of the following is a synonym for "Abundant"?',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, height: 1.4),
      ),
    );
  }

  Widget _buildOptionTile(String label, String text, bool isSelected, bool isCorrect) {
    Color borderColor = isSelected ? (isCorrect ? AppColors.primary : Colors.red) : AppColors.border;
    Color bgColor = isSelected ? (isCorrect ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE)) : Colors.white;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor, width: isSelected ? 2 : 1),
      ),
      child: Row(
        children: [
          Text('$label. ', style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? borderColor : AppColors.textMain)),
          Expanded(child: Text(text, style: TextStyle(fontSize: 16, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal))),
          if (isSelected)
            Icon(isCorrect ? Icons.check_circle : Icons.cancel, color: borderColor)
          else
            const Icon(Icons.circle_outlined, color: AppColors.border),
        ],
      ),
    );
  }

  Widget _buildAIAssistantGrid() {
    return Column(
      children: [
        const Center(child: Text('NEED A HINT?', style: TextStyle(fontSize: 10, color: Colors.grey, fontWeight: FontWeight.bold))),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 3,
          children: [
            _buildAIAction(Icons.lightbulb_outline, 'Explain Answer'),
            _buildAIAction(Icons.auto_awesome, 'Ask AI Tutor'),
            _buildAIAction(Icons.list_alt, 'Simplify Concept'),
            _buildAIAction(Icons.mic_none, 'Voice Ask'),
          ],
        ),
      ],
    );
  }

  Widget _buildAIAction(IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.blueGrey),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.auto_awesome_mosaic_outlined), label: ''),
        BottomNavigationBarItem(icon: CircleAvatar(radius: 18, backgroundColor: Color(0xFFE8F5E9), child: Icon(Icons.psychology, color: AppColors.primary)), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.translate), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.mic_none), label: ''),
      ],
    );
  }
}
