import 'package:flutter/widgets.dart';

abstract class IndicatorShape {
  const IndicatorShape._();

  static const defaultCircle = CircleShape(12.0);

  static const defaultRoundRectangle = RoundRectangleShape();

  static const defaultOval = OvalShape();

  factory IndicatorShape.circle({double size = 12.0}) {
    return CircleShape(size);
  }

  factory IndicatorShape.roundRectangleShape({
    Size size = const Size(12.0, 12.0),
    Size cornerSize = const Size.square(3),
  }) {
    return RoundRectangleShape(
      cornerSize: cornerSize,
      size: size,
    );
  }

  factory IndicatorShape.oval({Size size = const Size(12, 8)}) {
    return OvalShape(size: size);
  }

  double get height;

  double get width;
}

class CircleShape extends IndicatorShape {
  final double size;
  const CircleShape(this.size) : super._();

  @override
  double get height => size;

  @override
  double get width => size;
}

class RoundRectangleShape extends IndicatorShape {
  final Size size;
  final Size cornerSize;

  const RoundRectangleShape({
    this.size = const Size(12, 12),
    this.cornerSize = const Size.square(3),
  }) : super._();

  @override
  double get height => size.height;

  @override
  double get width => size.width;
}

class OvalShape extends IndicatorShape {
  final Size size;
  const OvalShape({
    this.size = const Size(12, 4),
  }) : super._();

  @override
  double get height => size.height;

  @override
  double get width => size.width;
}
