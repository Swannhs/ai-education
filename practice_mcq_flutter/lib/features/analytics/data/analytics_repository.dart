import '../domain/performance_stats.dart';

abstract class AnalyticsRepository {
  Future<PerformanceSummary> getFullReport(String userId);
}

class MockAnalyticsRepository implements AnalyticsRepository {
  @override
  Future<PerformanceSummary> getFullReport(String userId) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return PerformanceSummary(
      overallScore: 68.5,
      totalTestsTaken: 12,
      totalQuestionsSolved: 450,
      subjectStats: [
        SubjectPerformance(subjectName: 'Bangla', scorePercent: 0.82, questionsAnswered: 120),
        SubjectPerformance(subjectName: 'English', scorePercent: 0.54, questionsAnswered: 150),
        SubjectPerformance(subjectName: 'Math', scorePercent: 0.76, questionsAnswered: 180),
      ],
      weakTopics: [
        WeakTopic(
          topicName: 'English Prepositions',
          subjectName: 'English',
          accuracy: 15.0,
          aiSuggestion: 'Focus on "Prepositions of Place" next to avoid common "at/in/on" mistakes in BCS prelims.',
        ),
        WeakTopic(
          topicName: 'Medieval Literature',
          subjectName: 'Bangla',
          accuracy: 42.0,
          aiSuggestion: 'Review the chronology of the Pala and Sena dynasties.',
        ),
      ],
    );
  }
}
