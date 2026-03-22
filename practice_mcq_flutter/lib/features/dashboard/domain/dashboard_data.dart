class DashboardData {
  final double overallProgress;
  final String currentCourseTitle;
  final List<RoutineTask> todayTasks;
  final List<SubjectProgress> subjects;
  final String? aiRecommendation;

  DashboardData({
    required this.overallProgress,
    required this.currentCourseTitle,
    required this.todayTasks,
    required this.subjects,
    this.aiRecommendation,
  });
}

class RoutineTask {
  final String title;
  final String subtitle;
  final bool isCompleted;

  RoutineTask({required this.title, required this.subtitle, this.isCompleted = false});
}

class SubjectProgress {
  final String id;
  final String name;
  final int lessonCount;
  final String icon;

  SubjectProgress({required this.id, required this.name, required this.lessonCount, required this.icon});
}
