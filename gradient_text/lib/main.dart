import 'package:flutter/material.dart';

import 'gradient_text/simple_gradient_text.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gradient Text',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GradientText(
                  'Gradient Text Example',
                  style: const TextStyle(
                    fontSize: 40.0,
                  ),
                  colors: const [
                    Colors.blue,
                    Colors.red,
                    Colors.teal,
                  ],
                ),
                GradientText(
                  'Gradient Text Example',
                  style: const TextStyle(
                    fontSize: 40.0,
                  ),
                  gradientType: GradientType.radial,
                  radius: 2.5,
                  colors: const [
                    Colors.blue,
                    Colors.red,
                    Colors.teal,
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
