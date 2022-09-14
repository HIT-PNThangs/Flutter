import 'package:flutter/material.dart';

class DoubleShade {
  late final Color lightColor;
  late final Color darkColor;

  DoubleShade(this.lightColor, this.darkColor);
}

extension DarkMode on BuildContext {
  bool isDarkMode() {
    final brightness = MediaQuery.of(this).platformBrightness;
    return brightness == Brightness.dark;
  }
}

Color backgroundColor(BuildContext context) =>
    context.isDarkMode() ? Colors.black87 : const Color(0xffffffff);

DoubleShade blackColor(BuildContext context) {
  return context.isDarkMode() ?
  DoubleShade(Colors.white60, Colors.white) :
  DoubleShade(const Color(0xff313131), const Color(0xff121212));
}

const Color greenColor = Color(0xff5ce27f);
const Color yellowColor = Color(0xffffe12d);
const Color redColor = Color(0xffe25c5c);
// DoubleShade blackColor = DoubleShade(const Color(0xff313131), const Color(0xff121212));
DoubleShade grayColor = DoubleShade(const Color(0xffb1b1b1), const Color(0xffefefef));
DoubleShade greenGradient = DoubleShade(const Color(0xff5ce27f), const Color(0xff5cabe2));