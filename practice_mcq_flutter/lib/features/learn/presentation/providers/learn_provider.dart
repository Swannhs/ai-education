import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/learn_repository.dart';
import '../../domain/learn_models.dart';

final learnRepositoryProvider = Provider<LearnRepository>((ref) {
  return MockLearnRepository();
});

// Fetches all subjects
final subjectsProvider = FutureProvider<List<Subject>>((ref) async {
  final repo = ref.watch(learnRepositoryProvider);
  return repo.fetchSubjects();
});

// Fetched chapters for a specific subject
final chaptersProvider = FutureProvider.family<List<Chapter>, String>((ref, subjectId) async {
  final repo = ref.watch(learnRepositoryProvider);
  return repo.fetchChaptersBySubjectId(subjectId);
});

// Fetched topics for a specific chapter
final topicsProvider = FutureProvider.family<List<Topic>, String>((ref, chapterId) async {
  final repo = ref.watch(learnRepositoryProvider);
  return repo.fetchTopicsByChapterId(chapterId);
});

// Fetched lesson for a specific topic
final lessonProvider = FutureProvider.family<Lesson, String>((ref, topicId) async {
  final repo = ref.watch(learnRepositoryProvider);
  return repo.fetchLessonByTopicId(topicId);
});
