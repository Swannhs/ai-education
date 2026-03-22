import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:practice_mcq_flutter/main.dart';
import 'package:practice_mcq_flutter/features/auth/presentation/providers/auth_provider.dart';

void main() {
  testWidgets('Splash screen builds and displays the logo', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({});
    final sharedPrefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ],
        child: const PracticeMCQApp(),
      ),
    );

    // Initial pump
    await tester.pump();

    // Check for "Curator" text
    expect(find.text('Curator'), findsOneWidget);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
  });

  testWidgets('App shows login screen when unauthenticated after splash', (WidgetTester tester) async {
    // Mock SharedPreferences
    SharedPreferences.setMockInitialValues({}); // Empty = unauthenticated
    final sharedPrefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPrefs),
        ],
        child: const PracticeMCQApp(),
      ),
    );

    // Initial pump -> SplashScreen
    await tester.pump();
    
    // Auth initial is async, so pump and wait
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();

    // Should be on LoginScreen
    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
  });
}
