import 'package:flutter/material.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/social_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppLogoIcon(),
              const SizedBox(height: 24),
              const Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              const Text(
                'Continue your preparation',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              _buildLabel('Email Address'),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildLabel('Password'),
              _buildPasswordField(),
              _buildForgotPasswordLink(),
              const SizedBox(height: 24),
              PrimaryButton(
                text: 'Sign In',
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed(AppRouter.home);
                },
              ),
              const SizedBox(height: 32),
              _buildDivider(),
              const SizedBox(height: 32),
              SocialSignInButton(
                text: 'Continue with Google',
                icon: Icons.g_mobiledata,
                onPressed: () {},
              ),
              const SizedBox(height: 48),
              _buildSignUpPrompt(),
              const SizedBox(height: 40),
              _buildSecurityBadges(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppLogoIcon() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.accent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.menu_book,
        color: AppColors.primary,
        size: 32,
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEmailField() {
    return const TextField(
      decoration: InputDecoration(
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  Widget _buildPasswordField() {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: '........',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: Icon(Icons.visibility_off_outlined),
      ),
    );
  }

  Widget _buildForgotPasswordLink() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {},
        child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primary)),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR', style: TextStyle(color: AppColors.textSecondary)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSignUpPrompt() {
    return Center(
      child: RichText(
        text: const TextSpan(
          text: "Don't have an account? ",
          style: TextStyle(color: AppColors.textSecondary),
          children: [
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSecurityBadges() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified_user_outlined, size: 16, color: AppColors.textSecondary),
        SizedBox(width: 4),
        Text('SECURE LOGIN', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
        SizedBox(width: 24),
        Icon(Icons.cloud_done_outlined, size: 16, color: AppColors.textSecondary),
        SizedBox(width: 4),
        Text('PROGRESS SYNCED', style: TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      ],
    );
  }
}
