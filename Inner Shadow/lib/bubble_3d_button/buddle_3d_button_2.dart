
import 'dart:ui';

import 'package:flutter/material.dart';

class Bubble3DButton2 extends StatelessWidget {
  final Offset? offset;
  final BoxShadow? boxShadow;
  final Function()? onPressed;
  final Color? shadowColor;
  final Color? backgroundColor;
  final double? width, height;
  final BorderRadius? borderRadius;
  final Gradient? gradient;
  final double? radius;
  final double? blurRadius;
  final Widget? child;
  final EdgeInsets? padding, margin;

  const Bubble3DButton2(
      {super.key,
        this.offset,
        this.boxShadow,
        this.onPressed,
        this.shadowColor,
        this.width,
        this.height,
        this.backgroundColor,
        this.borderRadius,
        this.radius,
        this.blurRadius,
        this.child,
        this.gradient,
        this.padding,
        this.margin});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius:
          borderRadius ?? BorderRadius.circular(radius ?? 20.0),
          gradient: gradient,
          // color: backgroundColor ?? Colors.white,
          boxShadow: [
            BoxShadow(
              offset: Offset(0.0, 1.0),
              color: Colors.black.withOpacity(0.15),
              blurRadius: 4,
            ),
            BoxShadow(
              color: shadowColor ?? Colors.black.withOpacity(0.15),
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(0.0, -2.0),
              blurRadius: 4,
              spreadRadius: -1,
            )
          ],
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
