import 'package:flutter/widgets.dart';

TextSpan spanFromString(String text) {
  var index = 0;
  final styles = [
    const TextStyle(fontSize: 30),
    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    const TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
  ];
  final spans = text.split(' ').map((word) {
    if (index == 3) index = 0;
    return TextSpan(
      style: styles[index++],
      text: '$word ',
    );
  }).toList();

  return TextSpan(text: '', children: spans);
}
