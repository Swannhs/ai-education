import 'dart:async';
import '../models/ai_response.dart';
import '../models/ai_request.dart';

class CoreAIService {
  // Simulate network delay
  static Future<AIResponse> getAIResponse(AIRequest request) async {
    await Future.delayed(const Duration(milliseconds: 1500));

    switch (request.action) {
      case AIAction.explainQuestion:
        return AIResponse.fromJson({
          "summary": "Your error came from misunderstanding present perfect continuous.",
          "why_correct": "Option B is correct because 'for + duration' (three years) requires the present perfect continuous tense.",
          "why_wrong": "Option A uses 'since' wrongly with a duration (three years). Option C uses present continuous, which doesn't fit the 'for 3 years' duration.",
          "memory_tip": "Remember: SINCE = a point in time. FOR = a duration of time.",
          "exam_trick": "Whenever you see 'for' + time, look for 'has been' or 'have been' + verbing.",
          "bangla_explanation": "এখানে ৩ বছর একটা ব্যাপ্তি বা duration, তাই 'for' সঠিক। 'Since' বসে একটা নির্দিষ্ট সময় বা point in time এর ক্ষেত্রে।",
          "next_action": {"type": "practice_topic", "topic_id": "tense-03"}
        });

      case AIAction.simplifyLesson:
        return AIResponse.fromJson({
          "mode": "simplify",
          "response_title": "Shortcut Explanation",
          "content": "In algebraic formulas, focus on the (a+b)² expansion shortcuts used in past BCS papers.",
          "bullet_points": [
              "Focus on (a+b)² = a² + 2ab + b²",
              "Look for (a-b)² versions",
              "Shortcut for square root results"
          ],
          "memory_tip": "Think of the formula as a geometry square split into 4 parts.",
          "next_action": {"type": "practice_topic", "topic_id": "topic-1002"}
        });

      case AIAction.analyzePerformance:
      case AIAction.recommendNextAction:
        return AIResponse.fromJson({
          "headline": "Focus on Medieval Bengal today",
          "summary": "Overall summary: You missed 4 recent questions from this topic and have a mock test tomorrow.",
          "rationale": "Medieval Bengal questions appear in 80% of recent BCS exams.",
          "next_action": {
            "type": "open_topic_practice",
            "subject_id": "bangla",
            "topic_id": "medieval-bengal"
          }
        });

      default:
        return AIResponse(summary: "General AI response for ${request.action.name}");
    }
  }

  // Builder helpers
  static AIRequest explainQuestion({
    required String id,
    required String text,
    required String selectedOption,
    required String correctOption,
    required String subject,
    required String topic,
  }) {
    return AIRequest(
      action: AIAction.explainQuestion,
      context: {
        'id': id,
        'question': text,
        'selected_option': selectedOption,
        'correct_option': correctOption,
        'subject': subject,
        'topic': topic,
      },
    );
  }

  static AIRequest simplifyLesson(String lessonId, String contentParams) {
    return AIRequest(
      action: AIAction.simplifyLesson,
      context: {
        'lesson_id': lessonId,
        'parameters': contentParams,
      },
    );
  }

  static AIRequest analyzePerformance(String userId) {
    return AIRequest(
      action: AIAction.analyzePerformance,
      context: {
        'user_id': userId,
      },
    );
  }
}
