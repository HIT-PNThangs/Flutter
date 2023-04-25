import 'package:flutter/material.dart';

import 'unicorn_outline_button.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                UnicornOutlineButton(
                  strokeWidth: 2,
                  radius: 24,
                  gradient: const LinearGradient(colors: [Colors.black, Colors.redAccent]),
                  child: const Center(child: Text('OMG', style: TextStyle(fontSize: 16))),
                  onPressed: () {
                    debugPrint("Omg");
                  },
                ),
                const SizedBox(width: 0, height: 24),
                UnicornOutlineButton(
                  strokeWidth: 4,
                  radius: 16,
                  gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.yellow],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  child: const Center(child: Text('Wow', style: TextStyle(fontSize: 16))),
                  onPressed: () {
                    debugPrint("Wow");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
