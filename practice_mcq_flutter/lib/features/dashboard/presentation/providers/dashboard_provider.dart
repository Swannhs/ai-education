import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/dashboard_repository.dart';
import '../../domain/dashboard_data.dart';

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return MockDashboardRepository();
});

class DashboardNotifier extends StateNotifier<AsyncValue<DashboardData>> {
  final DashboardRepository _repository;

  DashboardNotifier(this._repository) : super(const AsyncValue.loading()) {
    fetch();
  }

  Future<void> fetch() async {
    state = const AsyncValue.loading();
    try {
      final data = await _repository.fetchDashboardStatistics();
      state = AsyncValue.data(data);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

final dashboardProvider = StateNotifierProvider<DashboardNotifier, AsyncValue<DashboardData>>((ref) {
  final repo = ref.watch(dashboardRepositoryProvider);
  return DashboardNotifier(repo);
});
