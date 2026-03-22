import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'GovPrep BD',
          style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildRecoveryHeader(),
              const SizedBox(height: 32),
              const Text(
                'Forgot Password?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain),
              ),
              const SizedBox(height: 8),
              const Text(
                'Enter your email to receive a recovery code',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 48),
              _buildLabel('EMAIL ADDRESS'),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'name@example.com',
                  fillColor: Color(0xFFEDF8FF),
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Send Code',
                onPressed: () {
                  Navigator.pushNamed(context, AppRouter.verifyCode);
                },
              ),
              const SizedBox(height: 40),
              _buildReturnToSignIn(context),
              const Spacer(),
              _buildSecuredByBadge(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecoveryHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        shape: BoxShape.circle,
      ),
      child: const Icon(
        Icons.lock_reset,
        size: 48,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildReturnToSignIn(BuildContext context) {
    return TextButton.icon(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios, size: 12, color: AppColors.textSecondary),
      label: const Text(
        'Return to Sign In',
        style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildSecuredByBadge() {
    return Column(
      children: [
        const Text(
          'SECURED BY BANGLADESH CIVIL SERVICE PREP PORTAL',
          style: TextStyle(color: AppColors.textSecondary, fontSize: 8, letterSpacing: 0.5),
        ),
        const SizedBox(height: 12),
        const Icon(Icons.verified_user, color: Colors.grey, size: 24),
      ],
    );
  }
}
