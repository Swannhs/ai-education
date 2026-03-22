import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/practice_repository.dart';
import '../domain/question.dart';

final practiceRepositoryProvider = Provider<PracticeRepository>((ref) {
  return MockPracticeRepository();
});

class PracticeState {
  final List<Question> questions;
  final int currentIndex;
  final Map<int, int> selectedOptions; // questionIndex -> selectedOptionIndex
  final bool isLoading;
  final String? error;

  PracticeState({
    this.questions = const [],
    this.currentIndex = 0,
    this.selectedOptions = const {},
    this.isLoading = false,
    this.error,
  });

  Question? get currentQuestion => questions.isNotEmpty ? questions[currentIndex] : null;
  bool get isLastQuestion => currentIndex == questions.length - 1;
  int get score => selectedOptions.entries.where((e) => questions[e.key].correctOptionIndex == e.value).length;

  PracticeState copyWith({
    List<Question>? questions,
    int? currentIndex,
    Map<int, int>? selectedOptions,
    bool? isLoading,
    String? error,
  }) {
    return PracticeState(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedOptions: selectedOptions ?? this.selectedOptions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class PracticeNotifier extends StateNotifier<PracticeState> {
  final PracticeRepository _repository;

  PracticeNotifier(this._repository) : super(PracticeState(isLoading: true));

  Future<void> startSession(String topicId) async {
    state = state.copyWith(isLoading: true);
    try {
      final questions = await _repository.fetchQuestionsByTopic(topicId);
      state = state.copyWith(questions: questions, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void selectOption(int optionIndex) {
    final Map<int, int> newSelection = Map.from(state.selectedOptions);
    newSelection[state.currentIndex] = optionIndex;
    state = state.copyWith(selectedOptions: newSelection);
  }

  void nextQuestion() {
    if (state.currentIndex < state.questions.length - 1) {
      state = state.copyWith(currentIndex: state.currentIndex + 1);
    }
  }

  void previousQuestion() {
    if (state.currentIndex > 0) {
      state = state.copyWith(currentIndex: state.currentIndex - 1);
    }
  }
}

final practiceProvider = StateNotifierProvider.family<PracticeNotifier, PracticeState, String>((ref, topicId) {
  final repo = ref.watch(practiceRepositoryProvider);
  final notifier = PracticeNotifier(repo);
  notifier.startSession(topicId);
  return notifier;
});
