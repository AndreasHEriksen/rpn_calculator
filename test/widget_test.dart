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


    expect(find.text('1 2 3'), findsOneWidget);
  });

  testWidgets('Test RPN calculator error handling', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: CalculatorScreen()));

    await tapButton(tester, '5');
    await tapButton(tester, '0');
    await tapButton(tester, '/');
    await tapButton(tester, 'Enter');

    expect(find.text('Error'), findsOneWidget);
  });

  testWidgets('Test addition operation in RPN calculator', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: CalculatorScreen()));


    await tester.tap(find.text('2'));
    await tester.tap(find.text('3'));
    await tester.tap(find.text('+'));

    await tester.tap(find.text('Enter'));
    await tester.pump();

    expect(find.text('5'), findsOneWidget);
  });


}

Future<void> tapButton(WidgetTester tester, String buttonText) async {
  await tester.tap(find.text(buttonText));
  await tester.pump();
}
