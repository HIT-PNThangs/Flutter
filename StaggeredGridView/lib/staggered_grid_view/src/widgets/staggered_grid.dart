import 'package:flutter/material.dart';

import '../rendering/staggered_grid.dart';

class StaggeredGrid extends MultiChildRenderObjectWidget {
  StaggeredGrid.custom({
    Key? key,
    required this.delegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
    this.axisDirection,
    List<Widget> children = const <Widget>[],
  })  : assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        super(key: key, children: children);

  StaggeredGrid.count({
    Key? key,
    required int crossAxisCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    AxisDirection? axisDirection,
    List<Widget> children = const <Widget>[],
  }) : this.custom(
          key: key,
          delegate: StaggeredGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          axisDirection: axisDirection,
          children: children,
        );

  StaggeredGrid.extent({
    Key? key,
    required double maxCrossAxisExtent,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
    AxisDirection? axisDirection,
    List<Widget> children = const <Widget>[],
  }) : this.custom(
          key: key,
          delegate: StaggeredGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
          axisDirection: axisDirection,
          children: children,
        );

  /// The delegate that controls the layout of the children.
  final StaggeredGridDelegate delegate;

  /// {@macro fsgv.global.mainAxisSpacing}
  final double mainAxisSpacing;

  /// {@macro fsgv.global.crossAxisSpacing}
  final double crossAxisSpacing;

  /// {@macro fsgv.global.axisDirection}
  final AxisDirection? axisDirection;

  @override
  RenderStaggeredGrid createRenderObject(BuildContext context) {
    return RenderStaggeredGrid(
      delegate: delegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      axisDirection: axisDirection ?? Scrollable.of(context).axisDirection,
      textDirection: Directionality.of(context),
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderStaggeredGrid renderObject,
  ) {
    renderObject
      ..delegate = delegate
      ..mainAxisSpacing = mainAxisSpacing
      ..crossAxisSpacing = crossAxisSpacing
      ..axisDirection = axisDirection ?? Scrollable.of(context).axisDirection
      ..textDirection = Directionality.of(context);
  }
}
