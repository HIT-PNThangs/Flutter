import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'neumorphic/calculator/neu_calculator_button.dart';
import 'neumorphic/calculator/neumorphic_theme.dart';
import 'neumorphic/neumorphic_bar/neumorphic_bar.dart';
import 'neumorphic/neumorphic_pie/middle_ring.dart';
import 'neumorphic/neumorphic_pie/neumorphic_pie.dart';
import 'neumorphic/neumorphic_start_page/neumophic_start_page.dart';
import 'neumorphic/timer/neu_reset_button.dart';
import 'neumorphic/timer/screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Neumorphic Widgets',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        canvasColor: kDarkBackgroundColour,
      ),
      theme: ThemeData(
        canvasColor: kBackgroundColour,
        scaffoldBackgroundColor: const Color.fromRGBO(231, 240, 247, 1),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              fontSize: 43,
              fontWeight: FontWeight.w900,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
          headlineMedium: GoogleFonts.dmSans(
            textStyle: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color.fromRGBO(49, 68, 105, 1),
            ),
          ),
        ),
        // colorScheme: ColorScheme(
        //   background: const Color.fromRGBO(231, 240, 247, 1),
        //   brightness: Brightness.dark,
        //   primary: kBackgroundColour,
        //   onPrimary: kBackgroundColour,
        //   secondary: kBackgroundColour, error: null,
        // ),
      ),
      home: Builder(
        builder: (context) {
          // return Scaffold(
          //   body: SafeArea(
          //     child: SingleChildScrollView(
          //       child: Column(
          //         children: [
          //           const SizedBox(height: 20),
          //           const MiddleRing(width: 400),
          //           const BarDays(),
          //           const SizedBox(height: 40),
          //           const NeumorphicPie(),
          //           // NeuDigitalClock(),
          //           NeuCalculatorButton(
          //             onPressed: () {},
          //             text: '0',
          //           ),
          //           const SizedBox(height: 20),
          //           const NeumorphicStartPage(),
          //           const TimerScreen(),
          //         ],
          //       ),
          //     ),
          //   ),
          // );
          return const TimerScreen();
        },
      ),
    );
  }
}

class BarDays extends StatelessWidget {
  const BarDays({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const <Widget>[
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 0.5,
          text: 'Mon',
        ),
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 0.9,
          text: 'Tue',
          color: Color.fromRGBO(0, 200, 156, 1),
        ),
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 0.7,
          text: 'Wed',
        ),
        NeumorphicBar(
          width: 200,
          height: 400,
          value: 1,
          text: 'Thur',
        ),
      ],
    );
  }
}
