import 'package:flutter/material.dart' hide BoxShadow;
import 'package:inner_shadow/bubble_3d_button/box_shadow.dart';
import 'package:inner_shadow/bubble_3d_button/bubble_3d_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Bubble3DButton(
              backgroundColor: Color(0xFFFF6464),
              // boxShadow: [
              //   BoxShadow(
              //     offset: Offset(0, 1),
              //     blurRadius: 4,
              //     color: Color(0xFF000000).withOpacity(0.25),
              //
              //   )
              // ],
            ),
          ],
        ),
      ),
    );
  }
}
