import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;

import 'box_decoration.dart';
import 'box_shadow.dart';

class Bubble3DButton extends StatelessWidget {
  final Offset? offset;
  final List<BoxShadow>? boxShadow;
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

  const Bubble3DButton(
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
        width: width ?? 100,
        height: height ?? 200,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 20.0),
          gradient: gradient,
          color: backgroundColor ?? Colors.white,
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  offset: offset ?? const Offset(0, -6),
                  blurRadius: blurRadius ?? 10,
                  color: shadowColor ?? Colors.black.withOpacity(0.45),
                  inset: true,
                ),
                BoxShadow(
                  offset: offset ?? const Offset(0, 1),
                  blurRadius: blurRadius ?? 6,
                  color: shadowColor ?? Colors.black.withOpacity(0.45),
                  inset: false,
                ),
              ],
        ),
        child: child ?? const SizedBox.shrink(),
      ),
    );
  }
}
