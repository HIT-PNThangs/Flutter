import 'package:calculator/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var userQuestion = "";
  var userAnswer = "";

  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(height: 50.0,),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    userQuestion,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    userAnswer,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ],
            )
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if(index == 0) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.green,
                      textColor: Colors.white,
                      buttonTaped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = '';
                        });
                      },
                    );
                  } else if(index == 1) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.red,
                      textColor: Colors.white,
                      buttonTaped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(0, userQuestion.length - 1);
                        });
                      },
                    );
                  } else if(index == buttons.length - 1) {
                    return MyButton(
                      buttonText: buttons[index],
                      color: Colors.deepPurple,
                      textColor:Colors.white,
                      buttonTaped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                    );
                  } else {
                    return MyButton(
                      buttonText: buttons[index],
                      color: isOperator(buttons[index]) ? Colors.deepPurple : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index]) ? Colors.white : Colors.deepPurple,
                      buttonTaped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    );
                  }
                })
          )
        ],
      ),
    );
  }

  bool isOperator(String x) {
    if(x == '%' || x == '/' || x == '-' || x == 'x' || x == '+' || x == '=') {
      return true;
    }

    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel contextModel = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, contextModel);

    userAnswer = eval.toString();
  }
}
