import '../domain/question.dart';

abstract class PracticeRepository {
  Future<List<Question>> fetchQuestionsByTopic(String topicId);
}

class MockPracticeRepository implements PracticeRepository {
  @override
  Future<List<Question>> fetchQuestionsByTopic(String topicId) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return [
      Question(
        id: 'q1',
        text: 'Which sentence is grammatically correct?',
        options: [
          'He has been working here since three years.',
          'He has been working here for three years.',
          'He is working here for three years.',
          'He worked here for three years.',
        ],
        correctOptionIndex: 1,
        difficulty: 'Medium',
        subject: 'English',
        topic: 'Tense',
      ),
      Question(
        id: 'q2',
        text: 'Who discovered the oldest manuscript of Charyapada?',
        options: [
          'Rabindranath Tagore',
          'Munier Chowdhury',
          'Haraprasad Shastri',
          'Ishwar Chandra Vidyasagar',
        ],
        correctOptionIndex: 2,
        difficulty: 'Hard',
        subject: 'Bangla',
        topic: 'Literature',
      ),
      Question(
        id: 'q3',
        text: 'The value of (a+b)² is:',
        options: [
          'a² - 2ab + b²',
          'a² + 2ab + b²',
          'a² + b²',
          '(a-b)² + 2ab',
        ],
        correctOptionIndex: 1,
        difficulty: 'Easy',
        subject: 'Math',
        topic: 'Algebra',
      ),
    ];
  }
}
