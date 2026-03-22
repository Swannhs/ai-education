import 'package:flutter/material.dart';

// Auth
import '../../features/auth/screens/splash_screen.dart';
import '../../features/auth/screens/login_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/auth/screens/forgot_password_screen.dart';
import '../../features/auth/screens/verify_email_screen.dart';
import '../../features/auth/screens/verify_code_screen.dart';
import '../../features/auth/screens/new_password_screen.dart';
import '../../features/auth/screens/exam_onboarding_screen.dart';

// Dashboard
import '../../features/dashboard/screens/home_screen.dart';

// Learn (New hierarchy)
import '../../features/learn/presentation/screens/subject_detail_screen.dart';
import '../../features/learn/presentation/screens/topic_list_screen.dart';
import '../../features/learn/presentation/screens/lesson_content_viewer_screen.dart';

// Legacy/Placeholder - these may need refactoring later
import '../../features/practice/presentation/screens/practice_screen.dart';
import '../../features/tests/screens/test_list_screen.dart';
import '../../features/profile/screens/profile_screen.dart';
import '../../features/routine/screens/daily_routine_screen.dart';
import '../../features/practice/screens/learn_library_screen.dart';
import '../../features/practice/presentation/screens/practice_result_screen.dart';
import '../../features/practice/screens/wrong_answers_screen.dart';
import '../../features/tests/screens/test_detail_screen.dart';
import '../../features/tests/screens/live_test_screen.dart';
import '../../features/tests/screens/test_result_screen.dart';
import '../../features/analytics/presentation/screens/analytics_screen.dart';
import '../../features/profile/screens/settings_screen.dart';
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
import '../../features/analytics/screens/progress_trends_screen.dart';
import '../../features/profile/screens/help_faq_screen.dart';
import '../../features/chat/screens/ai_recommendations_screen.dart';

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
  static const String learnLibrary = '/learn-library';
  static const String lessonContentViewer = '/lesson-content-viewer';
  static const String progressTrends = '/progress-trends';
  static const String helpFaq = '/help-faq';
  static const String aiRecommendations = '/ai-recommendations';
  static const String aiAssistant = '/ai-assistant';
  static const String voiceAssistant = '/voice-assistant';
  static const String reviewSubmission = '/review-submission';
  static const String questionPalette = '/question-palette';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case onboarding:
        return MaterialPageRoute(builder: (_) => const ExamOnboardingScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      
      case subjectDetail:
        final String? id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => SubjectDetailScreen(subjectId: id ?? '1'));
      
      case topicList:
        final String? id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => TopicListScreen(chapterId: id ?? 'c1'));
      
      case lesson:
        final String? id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => LessonContentViewerScreen(topicId: id ?? 't1'));

      case practice:
        final String? id = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => PracticeScreen(topicId: id ?? 't1'));

      case practiceResult:
        final int score = settings.arguments as int? ?? 0;
        return MaterialPageRoute(builder: (_) => PracticeResultScreen(score: score));
      case analytics:
        return MaterialPageRoute(builder: (_) => const AnalyticsScreen());
      case subscription:
        return MaterialPageRoute(builder: (_) => const SubscriptionPackagesScreen());
      case aiAssistant:
        return MaterialPageRoute(builder: (_) => const AIAssistantChatScreen());
      case testList:
        return MaterialPageRoute(builder: (_) => const TestListScreen());
      case testHistory:
        return MaterialPageRoute(builder: (_) => const TestHistoryScreen());
      case helpFaq:
        return MaterialPageRoute(builder: (_) => const HelpFAQScreen());
      case routine:
        return MaterialPageRoute(builder: (_) => const DailyRoutineScreen());
      case learnLibrary:
        return MaterialPageRoute(builder: (_) => const LearnLibraryScreen());
      case aiRecommendations:
        return MaterialPageRoute(builder: (_) => const AIRecommendationsScreen());
      case examPreferences:
        return MaterialPageRoute(builder: (_) => const ExamPreferencesScreen());
      case wrongAnswers:
        return MaterialPageRoute(builder: (_) => const WrongAnswersScreen());
      
      // Default fallback
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
