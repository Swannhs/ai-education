import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/services/ai_service.dart';
import '../../../core/models/ai_response.dart';
import '../domain/question.dart';
import '../presentation/providers/practice_provider.dart';

class PracticeScreen extends ConsumerWidget {
  final String topicId;
  const PracticeScreen({super.key, this.topicId = 't1'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(practiceProvider(topicId));
    final notifier = ref.read(practiceProvider(topicId).notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: _buildAppBarTitle(state),
        centerTitle: true,
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
              ? Center(child: Text('Error: ${state.error}'))
              : _buildContent(context, state, notifier),
      bottomNavigationBar: _buildBottomBar(context, state, notifier),
    );
  }

  Widget _buildContent(BuildContext context, PracticeState state, PracticeNotifier notifier) {
    final question = state.currentQuestion!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildQuestionHeader(question),
          const SizedBox(height: 24),
          _buildQuestionCard(question),
          const SizedBox(height: 32),
          _buildOptionsList(context, state, notifier, question),
          const SizedBox(height: 32),
          _buildAIAssistantSection(context, question),
        ],
      ),
    );
  }

  Widget _buildAppBarTitle(PracticeState state) {
    final progress = state.questions.isEmpty ? 0.0 : state.currentIndex / state.questions.length;
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
            widthFactor: progress,
            child: Container(decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(2))),
          ),
        ),
        const SizedBox(width: 8),
        Text('${state.currentIndex + 1}/${state.questions.length}', style: const TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildQuestionHeader(Question question) {
    return Wrap(
      spacing: 8,
      children: [
        _buildChip('Subject: ${question.subject}', Colors.blue),
        _buildChip('Topic: ${question.topic}', Colors.blue),
        _buildChip('Difficulty: ${question.difficulty}', Colors.orange),
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

  Widget _buildQuestionCard(Question question) {
    return Text(
      question.text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textMain),
    );
  }

  Widget _buildOptionsList(BuildContext context, PracticeState state, PracticeNotifier notifier, Question question) {
    final int? selectedIdx = state.selectedOptions[state.currentIndex];
    return Column(
      children: List.generate(question.options.length, (idx) {
        final label = String.fromCharCode(65 + idx); // A, B, C, D
        final optionText = question.options[idx];
        final bool isSelected = selectedIdx == idx;
        final bool isCorrect = isSelected && idx == question.correctOptionIndex;
        final bool isError = isSelected && idx != question.correctOptionIndex;

        return _buildOptionTile(
          label,
          optionText,
          isSelected: isSelected,
          isCorrect: isCorrect,
          isError: isError,
          onTap: () => notifier.selectOption(idx),
        );
      }),
    );
  }

  Widget _buildOptionTile(String label, String text, {bool isSelected = false, bool isCorrect = false, bool isError = false, required VoidCallback onTap}) {
    Color borderColor = AppColors.border;
    Color bgColor = Colors.white;
    if (isSelected) {
      borderColor = isError ? Colors.red : Colors.green;
      bgColor = isError ? const Color(0xFFFFEBEE) : const Color(0xFFE8F5E9);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(16), border: Border.all(color: borderColor, width: isSelected ? 2 : 1)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: isSelected ? borderColor : AppColors.background, borderRadius: BorderRadius.circular(8)),
              child: Text(label, style: TextStyle(color: isSelected ? Colors.white : AppColors.textMain, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500))),
            if (isCorrect) const Icon(Icons.check_circle, color: Colors.green),
            if (isError) const Icon(Icons.cancel, color: Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildAIAssistantSection(BuildContext context, Question question) {
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
            _buildAIAction(context, 'Explain Answer', Icons.lightbulb_outline, Colors.blue, question),
            _buildAIAction(context, 'Ask AI Tutor', Icons.psychology_outlined, Colors.purple, question),
            _buildAIAction(context, 'Simplify Text', Icons.auto_awesome_outlined, Colors.green, question),
            _buildAIAction(context, 'Voice Ask', Icons.mic_none, Colors.orange, question),
          ],
        ),
      ],
    );
  }

  Widget _buildAIAction(BuildContext context, String label, IconData icon, Color color, Question question) {
    return InkWell(
      onTap: () {
        if (label == 'Voice Ask') {
          Navigator.pushNamed(context, AppRouter.voiceAssistant);
        } else if (label == 'Ask AI Tutor') {
          Navigator.pushNamed(context, AppRouter.aiAssistant);
        } else {
          _showAIExplanation(context, label, question);
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

  void _showAIExplanation(BuildContext context, String label, Question question) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FutureBuilder<AIResponse>(
        future: CoreAIService.getAIResponse('EXPLAIN_QUESTION', {'question': question.text}),
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

  Widget _buildBottomBar(BuildContext context, PracticeState state, PracticeNotifier notifier) {
    final bool canGoNext = state.currentIndex < state.questions.length - 1;
    final bool canFinish = state.isFinished;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: AppColors.border))),
      child: Row(
        children: [
          IconButton(
            onPressed: state.currentIndex > 0 ? () => notifier.previousQuestion() : null,
            icon: const Icon(Icons.arrow_back_ios),
          ),
          const Spacer(),
          if (canGoNext)
            ElevatedButton(
              onPressed: () => notifier.nextQuestion(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(100, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Next'),
            )
          else if (canFinish)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, AppRouter.practiceResult, arguments: state.score);
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
