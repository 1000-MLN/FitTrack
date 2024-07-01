import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fit_track/start_screen.dart'; // Adjust the import path as necessary.

void main() {
  testWidgets('Start screen test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: StartScreen()),
      ),
    );
    // Verify if StartScreen shows the expected texts.
    expect(find.text("Fit Track"), findsOneWidget);
    // If "Nice to meet you" is not supposed to be found initially, this is correct:
    expect(find.text('Nice to meet you'), findsNothing);

    //Try to go to the next page without input name
    await tester.tap(find.text('Continue'));
    await tester.pump(); // This simulates the passing of time after an action.

    // Verify that we left on StartScreen page and not go to the next page without input name
    expect(find.text('Fit Track'), findsOneWidget);
    expect(find.text('Nice to meet you'), findsNothing);
    expect(find.text('Let\'s start!'), findsNothing);
  });
}
