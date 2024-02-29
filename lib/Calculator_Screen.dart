import 'package:flutter/material.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  List<String> stack = [];
  String display = '';

  void addToStack(String value) {
    setState(() {
      if (value == 'C') {
        // Clear the entire stack
        stack.clear();
      } else {
        stack.add(value);
      }
      display = stack.join(' ');
    });
  }

  void clearStack() {
    setState(() {
      stack.clear();
      display = '';
    });
  }

  void evaluate() {
    setState(() {
      if (stack.isNotEmpty) {
        String lastItem = stack.last;

        if (isOperator(lastItem)) {
          // If the last item is an operator, perform the calculation
          try {
            double result = rpnEvaluate(stack);
            stack.clear();
            stack.add(result.toString());
            display = stack.join(' ');
          } catch (e) {
            stack.clear();
            display = 'Error';
          }
        } else {
          // Concatenate the numbers when Enter is pressed
          String result = stack.join('');
          stack.clear();
          stack.add(result);
          display = stack.join(' ');
        }
      }
    });
  }

  bool isOperator(String value) {
    return value == '+' || value == '-' || value == '*' || value == '/';
  }

  double rpnEvaluate(List<String> expression) {
    List<double> stack = [];

    for (String token in expression) {
      if (double.tryParse(token) != null) {
        stack.add(double.parse(token));
      } else {
        double operand2 = stack.removeLast();
        double operand1 = stack.removeLast();

        switch (token) {
          case '+':
            stack.add(operand1 + operand2);
            break;
          case '-':
            stack.add(operand1 - operand2);
            break;
          case '*':
            stack.add(operand1 * operand2);
            break;
          case '/':
            if (operand2 != 0) {
              stack.add(operand1 / operand2);
            } else {
              throw Exception('Division by zero');
            }
            break;
          default:
            throw Exception('Invalid operator');
        }
      }
    }

    if (stack.length == 1) {
      return stack.first;
    } else {
      throw Exception('Invalid expression');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RPN Calculator',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(16),
              color: Colors.black,
              alignment: Alignment.bottomRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 36, color: Colors.white),
              ),
            ),
          ),
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton('7', () => addToStack('7')),
                    CalculatorButton('8', () => addToStack('8')),
                    CalculatorButton('9', () => addToStack('9')),
                    CalculatorButton('C', () => addToStack('C')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton('4', () => addToStack('4')),
                    CalculatorButton('5', () => addToStack('5')),
                    CalculatorButton('6', () => addToStack('6')),
                    CalculatorButton('/', () => addToStack('/')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton('1', () => addToStack('1')),
                    CalculatorButton('2', () => addToStack('2')),
                    CalculatorButton('3', () => addToStack('3')),
                    CalculatorButton('0', () => addToStack('0')),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CalculatorButton('-', () => addToStack('-')),
                    CalculatorButton('*', () => addToStack('*')),
                    CalculatorButton('+', () => addToStack('+')),
                    SizedBox(width: 24),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        child: ElevatedButton(
                          onPressed: () => evaluate(),
                          child: Text(
                            'Enter',
                            style: TextStyle(fontSize: 24),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: Colors.orange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ).copyWith(
                            backgroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.orange,
                            ),
                            foregroundColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final Function onTap;

  CalculatorButton(this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: ElevatedButton(
        onPressed: () => onTap(),
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(20),
          backgroundColor: Colors.orange,
          shape: CircleBorder(),
        ).copyWith(
          backgroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.orange,
          ),
          foregroundColor: MaterialStateProperty.resolveWith(
                (states) => Colors.white,
          ),
        ),
      ),
    );
  }
}
