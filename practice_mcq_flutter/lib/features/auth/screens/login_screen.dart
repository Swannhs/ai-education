import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/primary_button.dart';
import '../../../shared/widgets/social_button.dart';
import '../presentation/providers/auth_provider.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    // Listen to success state for navigation
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
              _buildEmailField(_emailController),
              const SizedBox(height: 20),
              _buildLabel('Password'),
              _buildPasswordField(_passwordController),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pushNamed(context, AppRouter.forgotPassword),
                  child: const Text('Forgot Password?', style: TextStyle(color: AppColors.primary)),
                ),
              ),
              const SizedBox(height: 24),
              if (authState.isLoading)
                const Center(child: CircularProgressIndicator())
              else
                PrimaryButton(
                  text: 'Sign In',
                  onPressed: () {
                    ref.read(authProvider.notifier).login(
                          _emailController.text,
                          _passwordController.text,
                        );
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
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(color: AppColors.textSecondary),
                    children: [
                      WidgetSpan(
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(context, AppRouter.signup),
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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

  Widget _buildEmailField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        hintText: 'Enter your email',
        prefixIcon: Icon(Icons.email_outlined),
      ),
    );
  }

  Widget _buildPasswordField(TextEditingController controller) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: '........',
        prefixIcon: Icon(Icons.lock_outline),
        suffixIcon: Icon(Icons.visibility_off_outlined),
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
