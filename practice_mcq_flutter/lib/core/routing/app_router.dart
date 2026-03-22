import 'package:flutter/material.dart';
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/dashboard/screens/home_screen.dart';

import '../../features/practice/screens/practice_screen.dart';

import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';

import '../../features/practice/screens/subject_detail_screen.dart';

import '../../features/tests/screens/test_list_screen.dart';

import '../../features/profile/screens/profile_screen.dart';

import '../../features/routine/screens/daily_routine_screen.dart';

import '../../features/practice/screens/learn_library_screen.dart';

import '../../features/practice/screens/practice_result_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String home = '/home';
  static const String practice = '/practice';
  static const String practiceResult = '/practice-result';
  static const String subjectDetail = '/subject-detail';
  static const String testList = '/test-list';
  static const String profile = '/profile';
  static const String routine = '/routine';
  static const String learn = '/learn';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignUpScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    home: (context) => const HomeScreen(),
    practice: (context) => const PracticeScreen(),
    practiceResult: (context) => const PracticeResultScreen(),
    subjectDetail: (context) => const SubjectDetailScreen(),
    testList: (context) => const TestListScreen(),
    profile: (context) => const ProfileScreen(),
    routine: (context) => const DailyRoutineScreen(),
    learn: (context) => const LearnLibraryScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case practice:
        return MaterialPageRoute(builder: (_) => const PracticeScreen());
      case practiceResult:
        return MaterialPageRoute(builder: (_) => const PracticeResultScreen());
      case subjectDetail:
        return MaterialPageRoute(builder: (_) => const SubjectDetailScreen());
      case testList:
        return MaterialPageRoute(builder: (_) => const TestListScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case routine:
        return MaterialPageRoute(builder: (_) => const DailyRoutineScreen());
      case learn:
        return MaterialPageRoute(builder: (_) => const LearnLibraryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
