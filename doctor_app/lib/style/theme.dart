import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {
  const Colors();

  static const Color loginGradientStart = Color(0xFF59499E);
  static const Color loginGradientEnd = Color(0xFF59499E);
  static const Color mainColor = Color(0xFF1561D5);
  static const Color successGreen = Color(0xFF32CD32);
  static const Color secondaryColor = Color(0xFFFFCB46);
  static const Color thirdColor = Color(0xFF091A68);
  static const Color fourthColor = Color(0xFF8FDCFF);
  static const Color elementBack = Color(0xfff1efef);
  static const Color titleBlack = Color(0xFF242424);
  static const Color textMain = Color(0xFF848484);
  static const Color greyBack = Color(0xFFced4db);
  static const Color grey = Color(0xFFb0b0b0);
  static const Color red = Color(0xFFff4d4d);
  static const Color orange = Color(0xFFff6348);
  static const Color strongGrey = Color(0xFFced4db);
  static const primaryGradient = LinearGradient(
    colors: [mainColor, mainColor],
    stops: [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
