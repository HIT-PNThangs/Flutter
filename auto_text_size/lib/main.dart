import 'package:flutter/material.dart';

import 'auto_text_size/auto_size_text.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: SizedBox(
              width: 200,
              height: 140,
              child: Column(
                children: const [
                  AutoSizeText(
                    'This string will be automatically resized to fit in two lines.',
                    style: TextStyle(fontSize: 30),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'This string will be automatically resized to fit in two lines.',
                    style: TextStyle(fontSize: 30),
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
