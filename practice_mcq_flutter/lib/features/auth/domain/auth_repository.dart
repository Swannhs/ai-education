import '../domain/user.dart';

abstract class AuthRepository {
  Future<User?> currentUser();
  Future<User> signIn(String email, String password);
  Future<User> signUp(String name, String email, String password);
  Future<void> signOut();
  Future<bool> isOnboardingComplete();
  Future<void> setOnboardingComplete(bool complete);
}
