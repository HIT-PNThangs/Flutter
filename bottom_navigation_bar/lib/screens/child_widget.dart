import 'package:flutter/material.dart';

class ChildWidget extends StatelessWidget {
  final AvailableNumber number;

  const ChildWidget({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String file = "";

    if (number == AvailableNumber.First) {
      file = "first";
    } else if (number == AvailableNumber.Second) {
      file = "second";
    } else if (number == AvailableNumber.Third) {
      file = "third";
    } else {
      file = "four";
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "$file screen",
          style: const TextStyle(fontSize: 36.0),
        ),
        Flexible(child: Image.asset("assets/undraw/$file.png"))
      ],
    );
  }
}

enum AvailableNumber { First, Second, Third, Four }
