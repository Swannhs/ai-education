class AIRequest {
  final AIAction action;
  final Map<String, dynamic> context;

  AIRequest({
    required this.action,
    required this.context,
  });

  Map<String, dynamic> toJson() => {
    'action': action.name,
    'context': context,
  };
}

enum AIAction {
  explainQuestion,
  simplifyLesson,
  analyzePerformance,
  recommendNextAction,
}
