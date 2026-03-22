import 'package:flutter_test/flutter_test.dart';
import 'package:practice_mcq_flutter/features/practice/domain/question.dart';
import 'package:practice_mcq_flutter/features/practice/data/practice_repository.dart';
import 'package:practice_mcq_flutter/features/practice/presentation/providers/practice_provider.dart';

class MockPracticeRepositoryImpl implements PracticeRepository {
  @override
  Future<List<Question>> fetchQuestionsByTopic(String topicId) async {
    return [
      Question(
        id: '1',
        text: 'What is 1+1?',
        options: ['1', '2', '3', '4'],
        correctOptionIndex: 1,
        explanation: '1+1=2',
        subject: 'Math',
        topic: 'Addition',
        difficulty: 'Easy',
      ),
      Question(
        id: '2',
        text: 'What is 2+2?',
        options: ['2', '3', '4', '5'],
        correctOptionIndex: 2,
        explanation: '2+2=4',
        subject: 'Math',
        topic: 'Addition',
        difficulty: 'Easy',
      ),
    ];
  }
}

void main() {
  group('PracticeNotifier', () {
    late MockPracticeRepositoryImpl repository;
    late PracticeNotifier notifier;

    setUp(() {
      repository = MockPracticeRepositoryImpl();
      notifier = PracticeNotifier(repository);
    });

    test('initial state is loading', () {
      expect(notifier.state.isLoading, true);
    });

    test('startSession loads questions', () async {
      await notifier.startSession('t1');
      expect(notifier.state.isLoading, false);
      expect(notifier.state.questions.length, 2);
      expect(notifier.state.currentIndex, 0);
    });

    test('selectOption updates state', () async {
      await notifier.startSession('t1');
      notifier.selectOption(1);
      expect(notifier.state.selectedOptions[0], 1);
    });

    test('score calculation', () async {
      await notifier.startSession('t1');
      notifier.selectOption(1); // Answer 1+1 correctly
      notifier.nextQuestion();
      notifier.selectOption(0); // Answer 2+2 incorrectly
      expect(notifier.state.score, 1);
    });

    test('isFinished logic', () async {
      await notifier.startSession('t1');
      expect(notifier.state.isFinished, false);
      notifier.selectOption(1);
      notifier.nextQuestion();
      notifier.selectOption(2);
      expect(notifier.state.isFinished, true);
    });
  });
}
