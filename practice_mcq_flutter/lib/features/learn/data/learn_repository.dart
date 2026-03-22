import '../domain/learn_models.dart';

abstract class LearnRepository {
  Future<List<Subject>> fetchSubjects();
  Future<List<Chapter>> fetchChaptersBySubjectId(String id);
  Future<List<Topic>> fetchTopicsByChapterId(String id);
  Future<Lesson> fetchLessonByTopicId(String id);
}

class MockLearnRepository implements LearnRepository {
  @override
  Future<List<Subject>> fetchSubjects() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Subject(id: '1', title: 'Bangla', icon: 'book', chapters: []),
      Subject(id: '2', title: 'English', icon: 'translate', chapters: []),
      Subject(id: '3', title: 'General Math', icon: 'calculate', chapters: []),
    ];
  }

  @override
  Future<List<Chapter>> fetchChaptersBySubjectId(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Chapter(id: 'c1', title: 'Ancient & Medieval History', description: 'Early developments in Bangla literature', topics: []),
      Chapter(id: 'c2', title: 'Modern Era (1801-Present)', description: 'Rise of prose, novels, and contemporary poets', topics: []),
      Chapter(id: 'c3', title: 'Language Movement', description: 'History and impact of 1952', topics: []),
    ];
  }

  @override
  Future<List<Topic>> fetchTopicsByChapterId(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return [
      Topic(id: 't1', title: 'Charyapada (The Oldest Prose)', lessonCount: 2, status: TopicStatus.completed),
      Topic(id: 't2', title: 'Introduction to Kavigana', lessonCount: 1, status: TopicStatus.inProgress),
      Topic(id: 't3', title: 'Rabindranath Tagore: Life & Works', lessonCount: 8, status: TopicStatus.notStarted),
    ];
  }

  @override
  Future<Lesson> fetchLessonByTopicId(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return Lesson(
      id: 'l1',
      title: 'The Origin of Charyapada',
      content: '# What is Charyapada?\n\nCharyapada is the oldest collected written version of the Bengali language found from the Royal Library of Nepal in 1907 by Haraprasad Shastri.',
      resources: [
        LessonResource(type: 'pdf', url: 'https://example.com/charyapada.pdf', label: 'Reference Guide'),
        LessonResource(type: 'video', url: 'https://youtube.com/example', label: 'Watch 5m Summary'),
      ],
    );
  }
}
