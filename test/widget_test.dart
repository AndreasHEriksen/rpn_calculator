import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/calculator_screen.dart';

void main() {
  testWidgets('Test if pressing numeric buttons adds to the stack in RPN', (
      WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CalculatorScreen()));

    await tapButton(tester, '1');
    await tapButton(tester, '2');
    await tapButton(tester, '3');

    // Check if the stack is correct in RPN
    expect(find.text('1 2 3'), findsOneWidget);
  });

  testWidgets('Test RPN calculator error handling', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CalculatorScreen()));

    await tapButton(tester, '5');
    await tapButton(tester, '0');
    await tapButton(tester, '/');
    await tapButton(tester, 'Enter');

    // Check if the display shows the error message
    expect(find.text('Error'), findsOneWidget);
  });

}

Future<void> tapButton(WidgetTester tester, String buttonText) async {
  await tester.tap(find.text(buttonText));
  await tester.pump();
}
