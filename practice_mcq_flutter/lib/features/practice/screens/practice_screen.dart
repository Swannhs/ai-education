import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/models/ai_response.dart';

class PracticeScreen extends StatelessWidget {
  const PracticeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildAppBarTitle(),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildQuestionHeader(),
            const SizedBox(height: 24),
            _buildQuestionCard(),
            const SizedBox(height: 32),
            _buildOptionsList(context),
            const SizedBox(height: 32),
            _buildAIAssistantSection(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildAppBarTitle() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.timer_outlined, size: 16, color: Colors.blue),
        const SizedBox(width: 4),
        const Text('12:45', style: TextStyle(color: Colors.blue, fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(width: 16),
        Container(
          height: 4,
          width: 80,
          decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(2)),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.65,
            child: Container(decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
          ),
        ),
        const SizedBox(width: 8),
        const Text('26/40', style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuestionHeader() {
    return Wrap(
      spacing: 8,
      children: [
        _buildChip('Subject: English', Colors.blue),
        _buildChip('Topic: Tense', Colors.blue),
        _buildChip('Difficulty: Medium', Colors.orange),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(6)),
      child: Text(label, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildQuestionCard() {
    return const Text(
      'Choose the correct sentence:',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain),
    );
  }

  Widget _buildOptionsList(BuildContext context) {
    return Column(
      children: [
        _buildOptionTile('A', 'He has been working here since three years.', isSelected: true, isError: true),
        _buildOptionTile('B', 'He has been working here for three years.', isCorrect: true),
        _buildOptionTile('C', 'He is working here for three years.', isSelected: false),
        _buildOptionTile('D', 'He worked here for three years.', isSelected: false),
      ],
    );
  }

  Widget _buildOptionTile(String label, String text, {bool isSelected = false, bool isCorrect = false, bool isError = false}) {
    Color borderColor = AppColors.border;
    Color bgColor = Colors.white;
    if (isSelected || isCorrect) {
      borderColor = isCorrect ? Colors.green : (isError ? Colors.red : AppColors.primary);
      bgColor = isCorrect ? const Color(0xFFE8F5E9) : (isError ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9));
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor, width: isSelected || isCorrect ? 2 : 1)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: isSelected || isCorrect ? borderColor : AppColors.background, borderRadius: BorderRadius.circular(8)),
            child: Text(label, style: TextStyle(color: isSelected || isCorrect ? Colors.white : AppColors.textMain, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
          if (isCorrect) const Icon(Icons.check_circle, color: Colors.green),
          if (isError) const Icon(Icons.cancel, color: Colors.red),
        ],
      ),
    );
  }

  Widget _buildAIAssistantSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('AI ASSISTANT', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 2.5,
          children: [
            _buildAIAction(context, 'Explain Answer', Icons.lightbulb_outline, Colors.blue),
            _buildAIAction(context, 'Ask AI Tutor', Icons.psychology_outlined, Colors.purple),
            _buildAIAction(context, 'Simplify Text', Icons.auto_awesome_outlined, Colors.green),
            _buildAIAction(context, 'Voice Ask', Icons.mic_none, Colors.orange),
          ],
        ),
      ],
    );
  }

  Widget _buildAIAction(BuildContext context, String label, IconData icon, Color color) {
    return InkWell(
      onTap: () {
        if (label == 'Voice Ask') {
          Navigator.pushNamed(context, AppRouter.voiceAssistant);
        } else if (label == 'Ask AI Tutor') {
          Navigator.pushNamed(context, AppRouter.aiAssistant);
        } else {
          _showAIExplanation(context, label);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  void _showAIExplanation(BuildContext context, String label) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FutureBuilder<AIResponse>(
        future: CoreAIService.getAIResponse('EXPLAIN_QUESTION', {}),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildLoadingSheet();
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return _buildErrorSheet();
          }
          final ai = snapshot.data!;
          return _buildAIResultSheet(context, ai, label);
        },
      ),
    );
  }

  Widget _buildLoadingSheet() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: AppColors.primary),
            SizedBox(height: 16),
            Text('AI Orchestration Layer working...', style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorSheet() {
    return Container(
      height: 200,
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: const Center(child: Text('AI service currently unavailable')),
    );
  }

  Widget _buildAIResultSheet(BuildContext context, AIResponse ai, String label) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: Colors.blue, size: 20),
              const SizedBox(width: 12),
              Text(label, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const Spacer(),
              IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 12),
          Text(ai.summary ?? '', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary)),
          const SizedBox(height: 16),
          const Text('WHY CORRECT:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          Text(ai.whyCorrect ?? '', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          const Text('WHY WRONG:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          Text(ai.whyWrong ?? '', style: const TextStyle(fontSize: 14)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: const Color(0xFFE1F5FE), borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                const Icon(Icons.lightbulb, color: Colors.blue),
                const SizedBox(width: 12),
                Expanded(child: Text(ai.memoryTip ?? '', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500))),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text('BANGLA EXPLANATION:', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
          Text(ai.banglaExplanation ?? '', style: const TextStyle(fontSize: 14, color: Color(0xFF1B5E20))),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Got it, Next Action'),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          const SizedBox(width: 8),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.practiceResult);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00695C),
              foregroundColor: Colors.white,
              minimumSize: const Size(140, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Finish Practice'),
          ),
        ],
      ),
    );
  }
}
