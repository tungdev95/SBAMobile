// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sba/src/screens/assets/detail/ptdb/ptdb_detail_page.dart';
import 'package:sba/src/widgets/custom_input_widget.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PTDBDetailPage());

    await tester.enterText(find.byType(CustomInputWidget), '1050000.50');
    // await tester.enterText(find.byType(CustomInputWidget), '.');
    // await tester.enterText(find.byType(CustomInputWidget), '5');

    // tester.testTextInput.enterText('1050000.50');
    tester.testTextInput.handleKeyDownEvent(LogicalKeyboardKey.arrowLeft);
    // Verify that our counter starts at 0.
    expect(find.text('1.050.000,50'), findsOneWidget);
    // expect(find.text('1'), findsNothing);

    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();

    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
