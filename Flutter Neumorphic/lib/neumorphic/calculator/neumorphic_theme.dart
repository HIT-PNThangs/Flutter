import 'package:flutter/material.dart';

class NeumorphicTheme {
  NeumorphicTheme({
    required this.outerShadow,
    required this.innerShadowColors,
    required this.borderColor,
    required this.buttonColor,
    this.isDark = false,
  });

  final List<BoxShadow> outerShadow;
  final List<Color> innerShadowColors;
  final Color borderColor;
  final Color buttonColor;
  final bool isDark;
}

final darkNeumorphicTheme = NeumorphicTheme(
  innerShadowColors: [
    kDarkBackgroundShadowColour,
    kOutline,
  ],
  borderColor: kOutline,
  buttonColor: kDarkBackgroundColour,
  outerShadow: kDarkBackgroundShadow,
  isDark: true,
);

final lightNeumorphicTheme = NeumorphicTheme(
  innerShadowColors: [kDarkShadow, Colors.white],
  borderColor: Colors.transparent,
  buttonColor: kBackgroundColour,
  outerShadow: kShadow,
);

const kBackgroundColour = Color.fromRGBO(239, 238, 238, 1);
const kOrange = Color.fromRGBO(238, 134, 48, 1); // rgb(238, 134, 48)
const kDarkShadow = Color.fromRGBO(216, 213, 208, 1); // rgb(216, 213, 208)
const kDarkBackgroundColour = Color.fromRGBO(38, 38, 38, 1); // rgb(38,38,38)
const kDarkBackgroundShadowColour = Color.fromRGBO(
  30,
  30,
  30,
  1,
); // rgb(30,30,30)
const kOutline = Color.fromRGBO(46, 46, 46, 1); // rgb(46,46,46)

final kShadow = [
  BoxShadow(
    blurRadius: 15,
    offset: -const Offset(5, 5),
    color: Colors.white,
  ),
  const BoxShadow(
    blurRadius: 15,
    offset: Offset(4.5, 4.5),
    color: kDarkShadow,
  )
];

final kDarkBackgroundShadow = [
  const BoxShadow(
    blurRadius: 15,
    offset: Offset(4.5, 4.5),
    color: kDarkBackgroundShadowColour,
  )
];
