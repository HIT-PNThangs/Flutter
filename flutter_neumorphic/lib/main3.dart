import 'package:flutter/material.dart';

import 'app/src/widget/container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Neumorphic(
          padding: const EdgeInsets.all(20),
          style: const NeumorphicStyle(
            depth: -8,
          ).copyWith(
            boxShape: const NeumorphicBoxShape.circle(),
          ),
          child: Neumorphic(
            style: const NeumorphicStyle(
              depth: -8,
              color: Color(0xFFFFFFFF)
            ).copyWith(
              boxShape: const NeumorphicBoxShape.circle(),
            ),
            child: const SizedBox(
              height: 100,
              width: 100,
            ),
          ),
        ),
      ),
    ));
  }
}

class Circle extends StatelessWidget {
  final Color color;
  final double width, height;

  const Circle({Key? key, required this.color, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        ),
        // Align(
        //   alignment: Alignment.center,
        //   child: Container(
        //     width: width - 50,
        //     height: height - 50,
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Color(0xFFFFFFFF),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.center,
          child: Neumorphic(
            style: const NeumorphicStyle(color: Colors.white, boxShape: NeumorphicBoxShape.circle()),
            child: SizedBox(
              height: height - 50,
              width: width - 50,
            ),
          ),
        )
      ],
    );
  }
}
