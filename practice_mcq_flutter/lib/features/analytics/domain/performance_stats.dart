class PerformanceSummary {
  final double overallScore;
  final int totalTestsTaken;
  final int totalQuestionsSolved;
  final List<SubjectPerformance> subjectStats;
  final List<WeakTopic> weakTopics;

  PerformanceSummary({
    required this.overallScore,
    required this.totalTestsTaken,
    required this.totalQuestionsSolved,
    required this.subjectStats,
    required this.weakTopics,
  });
}

class SubjectPerformance {
  final String subjectName;
  final double scorePercent;
  final int questionsAnswered;

  SubjectPerformance({required this.subjectName, required this.scorePercent, required this.questionsAnswered});
}

class WeakTopic {
  final String topicName;
  final String subjectName;
  final double accuracy;
  final String aiSuggestion;

  WeakTopic({
    required this.topicName,
    required this.subjectName,
    required this.accuracy,
    required this.aiSuggestion,
  });
}
