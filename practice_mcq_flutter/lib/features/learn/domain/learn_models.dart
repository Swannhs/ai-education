class Subject {
  final String id;
  final String title;
  final String icon;
  final List<Chapter> chapters;

  Subject({required this.id, required this.title, required this.icon, required this.chapters});
}

class Chapter {
  final String id;
  final String title;
  final String description;
  final List<Topic> topics;

  Chapter({required this.id, required this.title, required this.description, required this.topics});
}

class Topic {
  final String id;
  final String title;
  final int lessonCount;
  final TopicStatus status;

  Topic({required this.id, required this.title, this.lessonCount = 0, this.status = TopicStatus.notStarted});
}

enum TopicStatus { notStarted, inProgress, completed }

class Lesson {
  final String id;
  final String title;
  final String content;
  final List<LessonResource>? resources;

  Lesson({required this.id, required this.title, required this.content, this.resources});
}

class LessonResource {
  final String type; // 'pdf', 'video', 'audio'
  final String url;
  final String label;

  LessonResource({required this.type, required this.url, required this.label});
}
