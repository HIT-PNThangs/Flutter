import 'package:flutter/material.dart';
import 'package:splash_screen/css_gradient_converter.dart';

class AppColor {
  static const primaryColor = Color(0xFF5C27FE);
  static const secondaryColor = Color(0xFFBE64D9);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xFFFF9393);
  static const gray = Color(0xFFD9D9D9);
  static const grayText = Color(0xFFD4D4D4);
  static final linearGradientDialog = linearGradient(180, ['rgba(67, 5, 105, 0.8)-0%', 'rgba(127, 7, 200, 0.8)-100%']);
  static final linearGradient01 =
      // linearGradient(174.96, ['rgba(116, 55, 137, 1.0)-16.78%', 'rgba(49, 11, 139, 1.0)-79.95%']);
      linearGradient(143.96, ['rgba(165, 87, 189, 0.75)-16.78%', 'rgba(71, 28, 202, 0.75)-79.95%']);
  static final linearGradient02 =
      linearGradient(174.96, ['rgba(240, 8, 81, 1.0)-8.55%', 'rgba(127, 1, 109, 1.0)-75.18%']);
  static final linearGradient03 =
      linearGradient(180, ['rgba(190, 100, 217, 1.0)-24.82%', 'rgba(146, 80, 255, 1.0)-84.23%']);
  static final linearGradientLineH = linearGradient(
      90, ['rgba(255, 255, 255, 0)-0%', 'rgba(255, 255, 255, 0.5)-49.48%', 'rgba(255, 255, 255, 0)-100%']);
  static final linearGradientLineV = linearGradient(
      90, ['rgba(255, 255, 255, 0)-0%', 'rgba(255, 255, 255, 0.6)-13.02%', 'rgba(255, 255, 255, 0)-100%']);
}
