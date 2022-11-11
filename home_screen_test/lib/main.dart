import 'package:flutter/material.dart';
import 'package:home_screen_test/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: UserHomePage(),
        theme: ThemeData(brightness: Brightness.dark)
    );
  }
}
