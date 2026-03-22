import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';
import '../presentation/providers/auth_provider.dart';

class ExamOnboardingScreen extends ConsumerWidget {
  const ExamOnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            children: [
              const Spacer(),
              _buildIllustration(),
              const SizedBox(height: 48),
              const Text(
                'Welcome to The Curator',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain),
              ),
              const SizedBox(height: 16),
              const Text(
                'Your AI-powered ecosystem for Bangladesh government job preparation. Learn, Practice, Test, and Improve.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 15, height: 1.5),
              ),
              const SizedBox(height: 48),
              _buildFeatureItem(Icons.auto_awesome, 'AI Tutor', 'Personalized explanations and tips'),
              _buildFeatureItem(Icons.analytics_outlined, 'Deep Analytics', 'Identify and bridge your knowledge gaps'),
              _buildFeatureItem(Icons.event_note, 'Routine Planner', 'Structured study plan tailored for you'),
              const Spacer(),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(authProvider.notifier).completeOnboarding();
                  // Navigation will be handled by the listener in the parent or splash
                  // But for immediate feedback:
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, AppRouter.examPreferences);
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 56),
                  backgroundColor: const Color(0xFF006951),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Get Started', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIllustration() {
    return Container(
      width: 200,
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1),
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFF006951).withOpacity(0.1), width: 10),
      ),
      child: const Icon(Icons.school_outlined, size: 100, color: Color(0xFF006951)),
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: const Color(0xFFE0F2F1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: const Color(0xFF006951), size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
