import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/presentation/providers/auth_provider.dart';
import '../data/analytics_repository.dart';
import '../domain/performance_stats.dart';

final analyticsRepositoryProvider = Provider<AnalyticsRepository>((ref) {
  return MockAnalyticsRepository();
});

final performanceReportProvider = FutureProvider<PerformanceSummary>((ref) async {
  final user = ref.watch(authProvider).user;
  if (user == null) throw Exception('User not logged in');
  
  final repo = ref.watch(analyticsRepositoryProvider);
  return repo.getFullReport(user.id);
});
