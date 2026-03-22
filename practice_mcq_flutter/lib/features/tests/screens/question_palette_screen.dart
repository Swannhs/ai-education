import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class QuestionPaletteScreen extends StatelessWidget {
  const QuestionPaletteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Exam Review', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Finish', style: TextStyle(color: Color(0xFF00B074), fontWeight: FontWeight.bold))),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildProgressCard(),
            const SizedBox(height: 32),
            _buildLegend(),
            const SizedBox(height: 32),
            _buildPaletteGrid(),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, AppRouter.reviewSubmission),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 56),
                backgroundColor: const Color(0xFF00695C),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Submit Exam', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildProgressCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Overall Progress', style: TextStyle(color: AppColors.textSecondary, fontSize: 12, fontWeight: FontWeight.w500)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(text: '156', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black)),
                    TextSpan(text: ' / 200', style: TextStyle(fontSize: 20, color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              const Text('78% Complete', style: TextStyle(color: Color(0xFF00695C), fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 20),
          LinearProgressIndicator(value: 0.78, backgroundColor: const Color(0xFFF0F7FF), color: const Color(0xFF00B074), minHeight: 8, borderRadius: BorderRadius.circular(4)),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _buildLegendItem('Answered', const Color(0xFF00B074)),
        _buildLegendItem('Marked for Review', Colors.orange),
        _buildLegendItem('Unanswered', const Color(0xFFF0F7FF), textColor: AppColors.textMain),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color, {Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(20), border: Border.all(color: color.withOpacity(0.2))),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.circle, color: color, size: 8),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: textColor ?? color)),
        ],
      ),
    );
  }

  Widget _buildPaletteGrid() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24), border: Border.all(color: AppColors.border.withOpacity(0.5))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Question\nPalette', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, height: 1.2)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)), child: const Text('Section 1: General Science', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w500))),
            ],
          ),
          const SizedBox(height: 24),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, mainAxisSpacing: 12, crossAxisSpacing: 12),
            itemCount: 21, // 4 rows + 1 trailing
            itemBuilder: (context, index) {
              if (index < 20) {
                int qNum = index + 1;
                Color bgColor = Colors.white;
                Color textColor = Colors.black87;
                BoxBorder? border;

                if (qNum <= 4 || qNum == 7 || qNum == 17 || qNum == 18) {
                    bgColor = const Color(0xFF00B074);
                    textColor = Colors.white;
                } else if (qNum == 5 || qNum == 8) {
                    bgColor = Colors.orange;
                    textColor = Colors.white;
                } else {
                    bgColor = const Color(0xFFF0F7FF);
                    textColor = const Color(0xFF0D47A1);
                }

                if (qNum == 14) {
                    border = Border.all(color: const Color(0xFF00695C), width: 2);
                }

                return Container(
                  decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12), border: border),
                  child: Center(child: Text('$qNum', style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 13))),
                );
              } else {
                 return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('...', style: TextStyle(color: AppColors.textSecondary)),
                    Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(8)), child: const Text('200', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Color(0xFF0D47A1)))),
                 ]);
              }
            },
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
          _buildNavItem(Icons.help_outline, 'Questions', false),
          _buildNavItem(Icons.grid_view, 'Review', true),
          _buildNavItem(Icons.info_outline, 'Instructions', false),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: isActive ? BoxDecoration(color: const Color(0xFFE8F5E9), borderRadius: BorderRadius.circular(12)) : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: isActive ? const Color(0xFF00695C) : AppColors.textSecondary, size: 24),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: isActive ? const Color(0xFF00695C) : AppColors.textSecondary)),
        ],
      ),
    );
  }
}
