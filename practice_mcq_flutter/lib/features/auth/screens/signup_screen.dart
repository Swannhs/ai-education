import 'package:flutter/material.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/social_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLogo(context),
              const SizedBox(height: 48),
              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textMain,
                ),
              ),
              const Text(
                'Enter your details to get started',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 40),
              _buildLabel('FULL NAME'),
              _buildField('John Doe', Icons.person_outline),
              const SizedBox(height: 20),
              _buildLabel('EMAIL ADDRESS'),
              _buildField('name@example.com', Icons.alternate_email),
              const SizedBox(height: 20),
              _buildLabel('PASSWORD'),
              _buildPasswordField(),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Sign Up',
                onPressed: () {
                  // Navigate to Home or Verify screen
                  Navigator.pushNamed(context, AppRouter.verifyEmail);
                },
              ),
              const SizedBox(height: 32),
              _buildDivider(),
              const SizedBox(height: 32),
              SocialSignInButton(
                text: 'Google',
                icon: Icons.g_mobiledata,
                onPressed: () {},
              ),
              const SizedBox(height: 48),
              _buildSignInPrompt(context),
              const SizedBox(height: 60),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.account_balance, color: AppColors.primary, size: 24),
        const SizedBox(width: 8),
        const Text(
          'GovPrep BD',
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2, color: AppColors.textMain),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        fillColor: const Color(0xFFF0F7FF), // Matching the screenshot's light blue tint
      ),
    );
  }

  Widget _buildPasswordField() {
    return const TextField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: '........',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: Icon(Icons.visibility_outlined),
        fillColor: const Color(0xFFF0F7FF),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR CONTINUE WITH', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
        ),
        Expanded(child: Divider()),
      ],
    );
  }

  Widget _buildSignInPrompt(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () => Navigator.pop(context),
        child: RichText(
          text: const TextSpan(
            text: "Already have an account? ",
            style: TextStyle(color: AppColors.textSecondary),
            children: [
              TextSpan(
                text: 'Sign In',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return const Center(
      child: Column(
        children: [
          Text(
            '© 2024 GovPrep BD. All rights reserved.',
            style: TextStyle(color: AppColors.textSecondary, fontSize: 10),
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Privacy Policy', style: TextStyle(color: Colors.blue, fontSize: 10)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text('|', style: TextStyle(color: AppColors.textSecondary)),
              ),
              Text('Terms of Service', style: TextStyle(color: Colors.blue, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
