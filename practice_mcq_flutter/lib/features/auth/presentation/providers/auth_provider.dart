import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/auth_repository.dart';
import '../../data/mock_auth_repository.dart';
import '../../domain/user.dart';

// Provider for SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences not initialized in main.dart');
});

// Provider for AuthRepository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return MockAuthRepository(prefs);
});

// Auth state model
class AuthState {
  final User? user;
  final bool isLoading;
  final String? error;
  final bool onboardingComplete;
  final bool examPreferencesComplete;

  AuthState({
    this.user,
    this.isLoading = false,
    this.error,
    this.onboardingComplete = false,
    this.examPreferencesComplete = false,
  });

  AuthState copyWith({
    User? user,
    bool? isLoading,
    String? error,
    bool? onboardingComplete,
    bool? examPreferencesComplete,
  }) {
    return AuthState(
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      examPreferencesComplete: examPreferencesComplete ?? this.examPreferencesComplete,
    );
  }
}

// Notifier for Authentication state
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState(isLoading: true)) {
    _init();
  }

  Future<void> _init() async {
    final user = await _repository.currentUser();
    final onboarding = await _repository.isOnboardingComplete();
    final preferences = await _repository.isExamPreferencesComplete();
    state = AuthState(
      user: user, 
      isLoading: false, 
      onboardingComplete: onboarding, 
      examPreferencesComplete: preferences
    );
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repository.signIn(email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> signUp(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final user = await _repository.signUp(name, email, password);
      state = state.copyWith(user: user, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> logout() async {
    await _repository.signOut();
    state = AuthState(user: null, onboardingComplete: state.onboardingComplete, examPreferencesComplete: state.examPreferencesComplete);
  }

  Future<void> completeOnboarding() async {
    await _repository.setOnboardingComplete(true);
    state = state.copyWith(onboardingComplete: true);
  }

  Future<void> completeExamPreferences() async {
    await _repository.setExamPreferencesComplete(true);
    state = state.copyWith(examPreferencesComplete: true);
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthNotifier(repository);
});
