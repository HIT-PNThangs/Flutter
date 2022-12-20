import 'dart:ui';

import 'package:flutter/material.dart';

abstract class NeumorphicPathProvider extends CustomClipper<Path> {
  const NeumorphicPathProvider({Listenable? reclip}) : super(reclip: reclip);

  @override
  Path getClip(Size size) {
    return getPath(size);
  }

  bool get oneGradientPerPath;

  Path getPath(Size size);

  @override
  bool shouldReclip(NeumorphicPathProvider oldClipper) {
    return false;
  }
}
