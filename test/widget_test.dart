// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_flashcard/main.dart';

void main() {
  group("flash card", () {
    void iconChecking(IconData findsIcon) {
      expect(find.byIcon(Icons.edit),
          Icons.edit == findsIcon ? findsOneWidget : findsNothing);
      expect(find.byIcon(Icons.done),
          Icons.done == findsIcon ? findsOneWidget : findsNothing);
      expect(find.byIcon(Icons.error_outline),
          Icons.error_outline == findsIcon ? findsOneWidget : findsNothing);
    }

    void resetStatusChecking(WidgetTester tester) {
      iconChecking(Icons.edit);
      expect(
          (tester.firstWidget(find.byType(TextField)) as TextField)
                  .controller!
                  .text ==
              "",
          true);
    }

    testWidgets('Flashcard screen prev & next btn test',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FlashCardScreen());

      // Verify that our counter starts at 0.
      expect(find.text('What language does flutter uses?'), findsOneWidget);
      expect(find.text('What language does React uses?'), findsNothing);

      //input error text
      await tester.enterText(find.byType(TextField), "abc");
      await tester.pump();

      // Tap "next" btn.
      await tester.tap(find.byIcon(Icons.chevron_right));
      await tester.pump();

      //check reset status
      resetStatusChecking(tester);

      // Verify that our counter has incremented.
      expect(find.text('What language does flutter uses?'), findsNothing);
      expect(find.text('What language does React uses?'), findsOneWidget);

      //input error text
      await tester.enterText(find.byType(TextField), "abc");
      await tester.pump();

      // Tap "prev" btn.
      await tester.tap(find.byIcon(Icons.chevron_left));
      await tester.pump();

      //check reset status
      resetStatusChecking(tester);

      expect(find.text('What language does flutter uses?'), findsOneWidget);
      expect(find.text('What language does React uses?'), findsNothing);
    });

    testWidgets('Flashcard screen ans checking test',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const FlashCardScreen());

      //icon checking
      iconChecking(Icons.edit);

      //input error text
      await tester.enterText(find.byType(TextField), "abc");
      await tester.pump();

      //icon checking
      iconChecking(Icons.error_outline);

      //input correct text
      await tester.enterText(find.byType(TextField), "dart");
      await tester.pump();

      //icon checking
      iconChecking(Icons.done);
    });
  });
}
