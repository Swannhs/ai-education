import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Reset Password', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFF0F7FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.lock_reset, color: Color(0xFF00B074), size: 40),
            ),
            const SizedBox(height: 48),
            Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 20, offset: const Offset(0, 10))],
              ),
              child: Column(
                children: [
                  const Text('Create New\nPassword', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2)),
                  const SizedBox(height: 16),
                  const Text('Your new password must be different from previous passwords used with this account.', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.5)),
                  const SizedBox(height: 32),
                  _buildPasswordField('NEW PASSWORD', 'Enter your new password', _obscurePassword, () => setState(() => _obscurePassword = !_obscurePassword)),
                  const SizedBox(height: 24),
                  _buildPasswordField('CONFIRM NEW PASSWORD', 'Repeat your new password', _obscureConfirmPassword, () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword)),
                  const SizedBox(height: 24),
                  _buildRequirementList(),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(context, AppRouter.login),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      backgroundColor: const Color(0xFF00B074),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('Update Password', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)), SizedBox(width: 12), Icon(Icons.arrow_forward, size: 18)]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Having trouble? ', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                TextButton(onPressed: () {}, child: const Text('Contact Support', style: TextStyle(color: Color(0xFF006951), fontWeight: FontWeight.bold, fontSize: 13))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(String label, String hint, bool obscure, VoidCallback onToggle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.textSecondary, letterSpacing: 1.0)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
          child: TextField(
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
              border: InputBorder.none,
              suffixIcon: IconButton(icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined, color: AppColors.textSecondary, size: 20), onPressed: onToggle),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRequirementList() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF0F7FF), borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          _buildReqItem('At least 8 characters long', true),
          const SizedBox(height: 12),
          _buildReqItem('Include a number and symbol', false),
        ],
      ),
    );
  }

  Widget _buildReqItem(String text, bool isMet) {
    return Row(
      children: [
        Icon(isMet ? Icons.check_circle : Icons.circle, color: isMet ? const Color(0xFF1B5E20) : AppColors.border, size: 16),
        const SizedBox(width: 12),
        Text(text, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ],
    );
  }
}
