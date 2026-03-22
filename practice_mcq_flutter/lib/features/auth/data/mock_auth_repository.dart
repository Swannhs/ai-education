import 'package:shared_preferences/shared_preferences.dart';
import '../domain/auth_repository.dart';
import '../domain/user.dart';

class MockAuthRepository implements AuthRepository {
  final SharedPreferences _prefs;
  static const String _onboardingKey = 'onboarding_complete';
  static const String _preferencesKey = 'exam_preferences_complete';
  static const String _userKey = 'user_session';

  MockAuthRepository(this._prefs);

  @override
  Future<User?> currentUser() async {
    final userJson = _prefs.getString(_userKey);
    if (userJson != null) {
      return User(id: '1', name: 'Sadek Rahman', email: 'sadek@example.com', targetExam: 'BCS');
    }
    return null;
  }

  @override
  Future<User> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = User(id: '1', name: 'Sadek Rahman', email: email, targetExam: 'BCS');
    await _prefs.setString(_userKey, 'test_token');
    return user;
  }

  @override
  Future<User> signUp(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = User(id: '1', name: name, email: email, targetExam: 'BCS');
    await _prefs.setString(_userKey, 'test_token');
    return user;
  }

  @override
  Future<void> signOut() async {
    await _prefs.remove(_userKey);
  }

  @override
  Future<bool> isOnboardingComplete() async {
    return _prefs.getBool(_onboardingKey) ?? false;
  }

  @override
  Future<void> setOnboardingComplete(bool complete) async {
    await _prefs.setBool(_onboardingKey, complete);
  }

  @override
  Future<bool> isExamPreferencesComplete() async {
    return _prefs.getBool(_preferencesKey) ?? false;
  }

  @override
  Future<void> setExamPreferencesComplete(bool complete) async {
    await _prefs.setBool(_preferencesKey, complete);
  }
}
