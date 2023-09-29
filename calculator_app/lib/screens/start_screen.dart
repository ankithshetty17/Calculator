import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = '';
  String _output = '';

  void _handleButtonPress(String value) {
    setState(() {
      if (value == '=') {
        try {
          _output = _evaluateExpression(_input);
        } catch (e) {
          _output = 'Error';
        }
      } else if (value == 'C') {
        _input = '';
        _output = '';
      } else {
        _input += value;
      }
    });
  }

  String _evaluateExpression(String expression) {
    try {
      final parser = Parser();
      final context = ContextModel();
      final parsedExpression = parser.parse(expression);
      final evaluated = parsedExpression.evaluate(EvaluationType.REAL, context);

      // Format the result as a string with up to 2 decimal places
      return evaluated.toStringAsFixed(3);
    } catch (e) {
      return 'Error';
    }
  }
  Widget buildButton(String value) {
    return Expanded(
       child: Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: ElevatedButton(
        onPressed: () {
          _handleButtonPress(value);
        },
        child: Text(
          value,
          style: TextStyle(fontSize: 20,color: Color.fromARGB(255, 50, 155, 241)),
        ),
         style: ElevatedButton.styleFrom(
          backgroundColor:Colors.black,
          elevation: 10,
          minimumSize: const Size(
            double.infinity,
            50,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color:Color.fromARGB(255, 50, 155, 241)),
          ),
        ),
      ),
       ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  
        backgroundColor: Color.fromARGB(255, 19, 0, 0),
        centerTitle: true,
        title: Text(
        'POCKET CALCI',
        style: TextStyle(
          color: Color.fromARGB(255, 50, 155, 241),fontWeight: FontWeight.bold,
        ),
      ),
            shape: ContinuousRectangleBorder(
                 borderRadius: BorderRadius.circular(30.0), // Adjust the radius as needed
               ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text(
                _input,
                style: TextStyle(fontSize: 33,fontWeight: FontWeight.bold,color:Colors.red),
              ),
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(16),
              child: Text(
                _output,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold,color: Colors.green),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              
            children: [
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          Row(
            children: [
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          Row(
            children: [
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          Row(
            children: [
              buildButton('C'),
              buildButton('0'),
              buildButton('='),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }
}
