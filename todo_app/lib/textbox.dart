import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;

  const MyTextBox({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: Container(
          color: Colors.yellow[200],
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Text(text),
          ),
        ),
      ),
    );
  }
}
