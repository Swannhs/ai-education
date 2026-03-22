class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String? explanation;
  final String difficulty;
  final String subject;
  final String topic;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
    required this.difficulty,
    required this.subject,
    required this.topic,
  });
}

class PracticeSession {
  final List<Question> questions;
  final Map<int, int> userAnswers; // questionIndex -> selectedOptionIndex
  final DateTime startTime;
  final int timeLimitSeconds;

  PracticeSession({
    required this.questions,
    this.userAnswers = const {},
    required this.startTime,
    this.timeLimitSeconds = 3600,
  });

  bool get isFinished => userAnswers.length == questions.length;
}
