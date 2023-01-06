import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../core.dart';

abstract class ZShapeBuilder extends SingleChildRenderObjectWidget with ZWidget {
  final Color color;
  final double stroke;
  final bool closed;
  final bool fill;
  final ZVector front;
  final Color? backfaceColor;
  final bool visible;
  final ZVector? sortPoint;

  const ZShapeBuilder({
    Key? key,
    required this.color,
    this.front = const ZVector.only(z: 1),
    this.backfaceColor,
    this.stroke = 1,
    this.closed = true,
    this.fill = false,
    this.visible = true,
    this.sortPoint,
  })  : assert(stroke >= 0),
        super(key: key);

  /// The path that will define the shape of the Widget
  /// It is an ordered list of path commands : [ZMove], [ZLine], [ZArc] & [ZBezier]
  /// See some prebuilt shapes as examples:  [ZRect], [ZRounderRect], [ZEllipse]
  PathBuilder buildPath();

  @override
  RenderZShape createRenderObject(BuildContext context) {
    return RenderZShape(
        color: color,
        pathBuilder: buildPath(),
        stroke: stroke,
        close: closed,
        fill: fill,
        visible: visible,
        backfaceColor: backfaceColor,
        front: front,
        sortPoint: sortPoint);
  }

  @override
  void updateRenderObject(BuildContext context, RenderZShape renderObject) {
    renderObject.color = color;
    renderObject.pathBuilder = buildPath();
    renderObject.stroke = stroke;
    renderObject.close = closed;
    renderObject.fill = fill;
    renderObject.backfaceColor = backfaceColor;
    renderObject.front = front;
    renderObject.visible = visible;
    renderObject.sortPoint = sortPoint;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
    properties.add(DoubleProperty('stroke', stroke));
    properties.add(
      ColorProperty('backfaceColor', backfaceColor),
    );
  }

  @override
  ZSingleChildRenderObjectElement createElement() => ZSingleChildRenderObjectElement(this);
}

class ZShape extends ZShapeBuilder {
  final PathBuilder path;

  ZShape({
    Key? key,
    List<ZPathCommand>? path,
    required Color color,
    Color? backfaceColor,
    double stroke = 1,
    bool fill = false,
    ZVector front = const ZVector.only(z: 1),
    bool visible = true,
    bool closed = true,
  })  : path = SimplePathBuilder(path ?? const []),
        assert(stroke >= 0),
        super(
          key: key,
          color: color,
          backfaceColor: backfaceColor,
          stroke: stroke,
          closed: closed,
          fill: fill,
          front: front,
          visible: visible,
        );

  @override
  PathBuilder buildPath() => path;
}
