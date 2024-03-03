import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rpn_calculator/calculator_screen.dart';
import 'package:rpn_calculator/main.dart';

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


  testWidgets('Calculator number finder test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final numberFinder1 = find.text('1',);
    final numberFinder2 = find.text('2',);
    final numberFinder3 = find.text('3',);
    final numberFinder4 = find.text('4',);
    final numberFinder5 = find.text('5',);
    final numberFinder6 = find.text('6',);
    final numberFinder7 = find.text('7',);
    final numberFinder8 = find.text('8',);
    final numberFinder9 = find.text('9',);
    final numberFinder0 = find.text('0',);

    expect(numberFinder1, findsOneWidget);
    expect(numberFinder2, findsOneWidget);
    expect(numberFinder3, findsOneWidget);
    expect(numberFinder4, findsOneWidget);
    expect(numberFinder5, findsOneWidget);
    expect(numberFinder6, findsOneWidget);
    expect(numberFinder7, findsOneWidget);
    expect(numberFinder8, findsOneWidget);
    expect(numberFinder9, findsOneWidget);
    expect(numberFinder0, findsOneWidget);
  });

  testWidgets('Calculator operators finder test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final operatorFinder1 = find.text('/',);
    final operatorFinder2 = find.text('*',);
    final operatorFinder3 = find.text('-',);
    final operatorFinder4 = find.text('+',);
    final operatorFinder5 = find.text('Enter',);
    final operatorFinder6 = find.text('C',);

    expect(operatorFinder1, findsOneWidget);
    expect(operatorFinder2, findsOneWidget);
    expect(operatorFinder3, findsOneWidget);
    expect(operatorFinder4, findsOneWidget);
    expect(operatorFinder5, findsOneWidget);
    expect(operatorFinder6, findsOneWidget);
  });
}


Future<void> tapButton(WidgetTester tester, String buttonText) async {
  await tester.tap(find.text(buttonText));
  await tester.pump();
}
