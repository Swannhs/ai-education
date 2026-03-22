class AIResponse {
  final String? summary;
  final String? whyCorrect;
  final String? whyWrong;
  final String? memoryTip;
  final String? banglaExplanation;
  final String? examTrick;
  final String? mode; // e.g., 'simplify', 'explain', 'recommend'
  final String? responseTitle;
  final String? content;
  final List<String>? bulletPoints;
  final Map<String, dynamic>? nextAction;
  final String? rationale;
  final String? headline;

  AIResponse({
    this.summary,
    this.whyCorrect,
    this.whyWrong,
    this.memoryTip,
    this.banglaExplanation,
    this.examTrick,
    this.mode,
    this.responseTitle,
    this.content,
    this.bulletPoints,
    this.nextAction,
    this.rationale,
    this.headline,
  });

  factory AIResponse.fromJson(Map<String, dynamic> json) {
    return AIResponse(
      summary: json['summary'],
      whyCorrect: json['why_correct'],
      whyWrong: json['why_wrong'],
      memoryTip: json['memory_tip'],
      banglaExplanation: json['bangla_explanation'],
      examTrick: json['exam_trick'],
      mode: json['mode'],
      responseTitle: json['response_title'],
      content: json['content'],
      bulletPoints: json['bullet_points'] != null ? List<String>.from(json['bullet_points']) : null,
      nextAction: json['next_action'] != null ? Map<String, dynamic>.from(json['next_action']) : null,
      rationale: json['rationale'],
      headline: json['headline'],
    );
  }
}
