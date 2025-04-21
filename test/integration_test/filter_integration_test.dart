import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:new_project/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Filter venues from quick filter section', (tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Ensure the quick filter section is loaded
    final beachClubChip = find.text("Beach club");
    await tester.pumpUntilFound(beachClubChip);

    // Tap the filter chip (quick filter)
    await tester.tap(beachClubChip);
    await tester.pumpAndSettle();

    // Verify filtered venues show up
    expect(find.text("Ula Dubai"), findsOneWidget);
    expect(find.text("Zabeel House The Greens"), findsNothing);
  });
}

// Wait helper
extension PumpUntilFound on WidgetTester {
  Future<void> pumpUntilFound(
    Finder finder, {
    Duration timeout = const Duration(seconds: 5),
  }) async {
    final end = DateTime.now().add(timeout);
    while (DateTime.now().isBefore(end)) {
      await pump(const Duration(milliseconds: 100));
      if (any(finder)) return;
    }
    throw TestFailure(
      'Widget ${finder.evaluate().first} not found after $timeout',
    );
  }
}
