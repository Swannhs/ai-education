class User {
  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final String? targetExam;
  final bool isPremium;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.targetExam,
    this.isPremium = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'targetExam': targetExam,
      'isPremium': isPremium,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      profileImageUrl: json['profileImageUrl'],
      targetExam: json['targetExam'],
      isPremium: json['isPremium'] ?? false,
    );
  }
}
