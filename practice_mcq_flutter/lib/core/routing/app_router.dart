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

import '../../features/auth/screens/verify_email_screen.dart';

import '../../features/practice/screens/topic_list_screen.dart';

import '../../features/practice/screens/wrong_answers_screen.dart';

import '../../features/practice/screens/lesson_screen.dart';

import '../../features/auth/screens/verify_code_screen.dart';

import '../../features/tests/screens/test_detail_screen.dart';

import '../../features/tests/screens/live_test_screen.dart';

import '../../features/tests/screens/test_result_screen.dart';

import '../../features/analytics/screens/analytics_screen.dart';

import '../../features/profile/screens/settings_screen.dart';
import '../../features/auth/screens/new_password_screen.dart';
import '../../features/auth/screens/exam_onboarding_screen.dart';
import '../../features/practice/screens/favorites_library_screen.dart';
import '../../features/tests/screens/past_papers_screen.dart';
import '../../features/chat/screens/ai_assistant_chat_screen.dart';
import '../../features/chat/screens/voice_assistant_screen.dart';
import '../../features/tests/screens/review_submission_screen.dart';
import '../../features/tests/screens/question_palette_screen.dart';
import '../../features/profile/screens/subscription_packages_screen.dart';
import '../../features/profile/screens/exam_preferences_screen.dart';
import '../../features/analytics/screens/subject_performance_screen.dart';
import '../../features/analytics/screens/weak_topics_analysis_screen.dart';
import '../../features/analytics/screens/test_history_screen.dart';
import '../../features/tests/screens/merit_list_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmail = '/verify-email';
  static const String verifyCode = '/verify-code';
  static const String newPassword = '/new-password';
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String practice = '/practice';
  static const String practiceResult = '/practice-result';
  static const String subjectDetail = '/subject-detail';
  static const String topicList = '/topic-list';
  static const String wrongAnswers = '/wrong-answers';
  static const String favorites = '/favorites';
  static const String lesson = '/lesson';
  static const String testList = '/test-list';
  static const String testDetail = '/test-detail';
  static const String pastPapers = '/past-papers';
  static const String liveTest = '/live-test';
  static const String testResult = '/test-result';
  static const String meritList = '/merit-list';
  static const String analytics = '/analytics';
  static const String subjectPerformance = '/subject-performance';
  static const String weakTopics = '/weak-topics';
  static const String testHistory = '/test-history';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String subscription = '/subscription';
  static const String examPreferences = '/exam-preferences';
  static const String routine = '/routine';
  static const String learn = '/learn';
  static const String aiAssistant = '/ai-assistant';
  static const String voiceAssistant = '/voice-assistant';
  static const String reviewSubmission = '/review-submission';
  static const String questionPalette = '/question-palette';

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    signup: (context) => const SignUpScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    verifyEmail: (context) => const VerifyEmailScreen(),
    verifyCode: (context) => const VerifyCodeScreen(),
    newPassword: (context) => const NewPasswordScreen(),
    onboarding: (context) => const ExamOnboardingScreen(),
    home: (context) => const HomeScreen(),
    practice: (context) => const PracticeScreen(),
    practiceResult: (context) => const PracticeResultScreen(),
    subjectDetail: (context) => const SubjectDetailScreen(),
    topicList: (context) => const TopicListScreen(),
    wrongAnswers: (context) => const WrongAnswersScreen(),
    favorites: (context) => const FavoritesLibraryScreen(),
    lesson: (context) => const LessonScreen(),
    testList: (context) => const TestListScreen(),
    testDetail: (context) => const TestDetailScreen(),
    pastPapers: (context) => const PastPapersScreen(),
    liveTest: (context) => const LiveTestScreen(),
    testResult: (context) => const TestResultScreen(),
    meritList: (context) => const MeritListScreen(),
    analytics: (context) => const AnalyticsScreen(),
    subjectPerformance: (context) => const SubjectPerformanceScreen(),
    weakTopics: (context) => const WeakTopicsAnalysisScreen(),
    testHistory: (context) => const TestHistoryScreen(),
    profile: (context) => const ProfileScreen(),
    settings: (context) => const SettingsScreen(),
    subscription: (context) => const SubscriptionPackagesScreen(),
    examPreferences: (context) => const ExamPreferencesScreen(),
    routine: (context) => const DailyRoutineScreen(),
    learn: (context) => const LearnLibraryScreen(),
    aiAssistant: (context) => const AIAssistantChatScreen(),
    voiceAssistant: (context) => const VoiceAssistantScreen(),
    reviewSubmission: (context) => const ReviewSubmissionScreen(),
    questionPalette: (context) => const QuestionPaletteScreen(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case verifyEmail:
        return MaterialPageRoute(builder: (_) => const VerifyEmailScreen());
      case verifyCode:
        return MaterialPageRoute(builder: (_) => const VerifyCodeScreen());
      case newPassword:
        return MaterialPageRoute(builder: (_) => const NewPasswordScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const ExamOnboardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case practice:
        return MaterialPageRoute(builder: (_) => const PracticeScreen());
      case practiceResult:
        return MaterialPageRoute(builder: (_) => const PracticeResultScreen());
      case subjectDetail:
        return MaterialPageRoute(builder: (_) => const SubjectDetailScreen());
      case topicList:
        return MaterialPageRoute(builder: (_) => const TopicListScreen());
      case wrongAnswers:
        return MaterialPageRoute(builder: (_) => const WrongAnswersScreen());
      case favorites:
        return MaterialPageRoute(builder: (_) => const FavoritesLibraryScreen());
      case lesson:
        return MaterialPageRoute(builder: (_) => const LessonScreen());
      case testList:
        return MaterialPageRoute(builder: (_) => const TestListScreen());
      case testDetail:
        return MaterialPageRoute(builder: (_) => const TestDetailScreen());
      case pastPapers:
        return MaterialPageRoute(builder: (_) => const PastPapersScreen());
      case liveTest:
        return MaterialPageRoute(builder: (_) => const LiveTestScreen());
      case testResult:
        return MaterialPageRoute(builder: (_) => const TestResultScreen());
      case meritList:
        return MaterialPageRoute(builder: (_) => const MeritListScreen());
      case analytics:
        return MaterialPageRoute(builder: (_) => const AnalyticsScreen());
      case subjectPerformance:
        return MaterialPageRoute(builder: (_) => const SubjectPerformanceScreen());
      case weakTopics:
        return MaterialPageRoute(builder: (_) => const WeakTopicsAnalysisScreen());
      case testHistory:
        return MaterialPageRoute(builder: (_) => const TestHistoryScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case subscription:
        return MaterialPageRoute(builder: (_) => const SubscriptionPackagesScreen());
      case examPreferences:
        return MaterialPageRoute(builder: (_) => const ExamPreferencesScreen());
      case routine:
        return MaterialPageRoute(builder: (_) => const DailyRoutineScreen());
      case learn:
        return MaterialPageRoute(builder: (_) => const LearnLibraryScreen());
      case aiAssistant:
        return MaterialPageRoute(builder: (_) => const AIAssistantChatScreen());
      case voiceAssistant:
        return MaterialPageRoute(builder: (_) => const VoiceAssistantScreen());
      case reviewSubmission:
        return MaterialPageRoute(builder: (_) => const ReviewSubmissionScreen());
      case questionPalette:
        return MaterialPageRoute(builder: (_) => const QuestionPaletteScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${routeSettings.name}')),
          ),
        );
    }
  }
}
