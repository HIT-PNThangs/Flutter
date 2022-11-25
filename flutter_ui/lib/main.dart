import 'package:flutter/material.dart';

import 'home_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Consolas'
      ),
      title: "Flutter精美UI系列视频",
      home: HomePage(),
    );
  }
}
