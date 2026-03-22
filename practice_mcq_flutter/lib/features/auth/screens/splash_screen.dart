import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/routing/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRouter.examPreferences);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _buildLogo(),
              const SizedBox(height: 48),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(text: 'The ', style: TextStyle(color: Colors.black)),
                    TextSpan(text: 'Curator', style: TextStyle(color: Color(0xFF006951))),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text('THE CURATED PATH TO SUCCESS', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 2.0)),
              const Spacer(flex: 2),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: LinearProgressIndicator(
                  backgroundColor: const Color(0xFFE0F2F1),
                  color: const Color(0xFF006951),
                  minHeight: 2,
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sync, color: AppColors.textSecondary, size: 14),
                  SizedBox(width: 8),
                  Text('PREPARING WORKSPACE', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                ],
              ),
              const Spacer(),
              const Text('Dedicated to the Civil Service of Bangladesh', style: TextStyle(color: AppColors.textSecondary, fontSize: 10, fontWeight: FontWeight.w400)),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          width: 140,
          height: 140,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 30, offset: Offset(0, 15))],
          ),
          child: Container(
            decoration: BoxDecoration(color: const Color(0xFF009688), borderRadius: BorderRadius.circular(20)),
            child: const Icon(Icons.school, color: Colors.white, size: 50),
          ),
        ),
        Positioned(
          top: 10,
          right: 15,
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: Colors.white, size: 12),
          ),
        ),
      ],
    );
  }
}
