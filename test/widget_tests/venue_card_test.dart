import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:new_project/features/venues/domain/entities/venue_entity.dart';
import 'package:new_project/features/venues/presentation/widgets/venue_card.dart';

void main() {
  testWidgets('VenueCard displays venue data and handles tap', (
    WidgetTester tester,
  ) async {
    bool tapped = false;

    final venue = VenueEntity(
      name: 'Test Venue',
      location: 'Palm Jumeirah',
      city: 'Dubai',
      images: [],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: 200,
              child: VenueCard(venue: venue, onTap: () => tapped = true),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Test Venue'), findsOneWidget);
    expect(find.textContaining('Palm Jumeirah'), findsOneWidget);
    expect(find.textContaining('Dubai'), findsOneWidget);

    await tester.tap(find.byType(VenueCard));
    expect(tapped, isTrue);
  });
}
