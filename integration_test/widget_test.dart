// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sba/src/models/base/base.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group('description', () {
    testWidgets('Counter increments smoke test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: const Text('Custom Input Widget'),
          ),
          body: CustomInputWidget(
            inputFieldModel: InputFieldModel<double>(
              data: null,
            ),
          ),
        ),
      ));

      await tester.enterText(find.byType(CustomInputWidget), '100');
      await tester.enterText(find.byType(CustomInputWidget), '.');
      await tester.enterText(find.byType(CustomInputWidget), '5');
      // await tester.pumpAndSettle();

      // Verify that our counter starts at 0.
      expect(find.text('100,5'), findsOneWidget);
      // expect(find.text('1'), findsNothing);

      // // Tap the '+' icon and trigger a frame.
      // await tester.tap(find.byIcon(Icons.add));
      // await tester.pump();

      // // Verify that our counter has incremented.
      // expect(find.text('0'), findsNothing);
      // expect(find.text('1'), findsOneWidget);
    });
  });
}
