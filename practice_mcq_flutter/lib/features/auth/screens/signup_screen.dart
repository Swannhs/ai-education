import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/social_button.dart';
import '../presentation/providers/auth_provider.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen for auth success
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.user != null) {
        if (!next.onboardingComplete) {
          Navigator.of(context).pushReplacementNamed(AppRouter.onboarding);
        } else if (!next.examPreferencesComplete) {
          Navigator.of(context).pushReplacementNamed(AppRouter.examPreferences);
        } else {
          Navigator.of(context).pushReplacementNamed(AppRouter.home);
        }
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error!), backgroundColor: Colors.red),
        );
      }
    });

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLogoHeader(),
                const SizedBox(height: 48),
                const Text(
                  'Create Account',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textMain),
                ),
                const Text(
                  'Enter your details to get started',
                  style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 40),
                _buildLabel('FULL NAME'),
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'John Doe', prefixIcon: Icon(Icons.person_outline)),
                  validator: (v) => (v == null || v.isEmpty) ? 'Please enter your name' : null,
                ),
                const SizedBox(height: 20),
                _buildLabel('EMAIL ADDRESS'),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'name@example.com', prefixIcon: Icon(Icons.alternate_email)),
                  validator: (v) => (v == null || !v.contains('@')) ? 'Please enter a valid email' : null,
                ),
                const SizedBox(height: 20),
                _buildLabel('PASSWORD'),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(hintText: '........', prefixIcon: Icon(Icons.lock_outline), suffixIcon: Icon(Icons.visibility_outlined)),
                  validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null,
                ),
                const SizedBox(height: 32),
                if (authState.isLoading)
                  const Center(child: CircularProgressIndicator())
                else
                  PrimaryButton(
                    text: 'Sign Up',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(authProvider.notifier).signUp(
                          _nameController.text,
                          _emailController.text,
                          _passwordController.text,
                        );
                      }
                    },
                  ),
                const SizedBox(height: 32),
                _buildDivider(),
                const SizedBox(height: 32),
                SocialSignInButton(text: 'Google', icon: Icons.g_mobiledata, onPressed: () {}),
                const SizedBox(height: 48),
                _buildSignInPrompt(context),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.account_balance, color: AppColors.primary, size: 24),
        const SizedBox(width: 8),
        const Text('GovPrep BD', style: TextStyle(color: AppColors.primary, fontSize: 20, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1.2, color: AppColors.textMain)),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('OR', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold)),
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
              TextSpan(text: 'Sign In', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
