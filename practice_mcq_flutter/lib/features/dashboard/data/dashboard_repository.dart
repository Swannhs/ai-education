import '../domain/dashboard_data.dart';

abstract class DashboardRepository {
  Future<DashboardData> fetchDashboardStatistics();
}

class MockDashboardRepository implements DashboardRepository {
  @override
  Future<DashboardData> fetchDashboardStatistics() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return DashboardData(
      overallProgress: 0.65,
      currentCourseTitle: 'BCS Foundation Course',
      aiRecommendation: 'Focus on Medieval Bengal today to boost your score by 15%',
      todayTasks: [
        RoutineTask(title: 'Daily MCQ Challenge', subtitle: 'General Knowledge • Completed', isCompleted: true),
        RoutineTask(title: 'Bangla Literature - Ch 4', subtitle: 'Ancient & Medieval era', isCompleted: false),
        RoutineTask(title: 'English Grammar: Tense', subtitle: 'Practice Set 12', isCompleted: false),
      ],
      subjects: [
        SubjectProgress(name: 'Bangla', lessonCount: 45, icon: 'book'),
        SubjectProgress(name: 'English', lessonCount: 38, icon: 'translate'),
        SubjectProgress(name: 'General Math', lessonCount: 52, icon: 'calculate'),
      ],
    );
  }
}
