import 'package:flutter/material.dart';

import '../rendering/sliver_masonry_grid.dart';
import '../rendering/sliver_simple_grid_delegate.dart';

class SliverMasonryGrid extends SliverMultiBoxAdaptorWidget {
  const SliverMasonryGrid({
    Key? key,
    required SliverChildDelegate delegate,
    required this.gridDelegate,
    this.mainAxisSpacing = 0,
    this.crossAxisSpacing = 0,
  })  : assert(mainAxisSpacing >= 0),
        assert(crossAxisSpacing >= 0),
        super(key: key, delegate: delegate);

  SliverMasonryGrid.count({
    Key? key,
    required int crossAxisCount,
    required IndexedWidgetBuilder itemBuilder,
    int? childCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
  }) : this(
          key: key,
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: childCount,
          ),
          gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        );

  SliverMasonryGrid.extent({
    Key? key,
    required double maxCrossAxisExtent,
    required IndexedWidgetBuilder itemBuilder,
    int? childCount,
    double mainAxisSpacing = 0,
    double crossAxisSpacing = 0,
  }) : this(
          key: key,
          delegate: SliverChildBuilderDelegate(
            itemBuilder,
            childCount: childCount,
          ),
          gridDelegate: SliverSimpleGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: maxCrossAxisExtent,
          ),
          mainAxisSpacing: mainAxisSpacing,
          crossAxisSpacing: crossAxisSpacing,
        );

  final SliverSimpleGridDelegate gridDelegate;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  RenderSliverMasonryGrid createRenderObject(BuildContext context) {
    final SliverMultiBoxAdaptorElement element = context as SliverMultiBoxAdaptorElement;
    return RenderSliverMasonryGrid(
      childManager: element,
      gridDelegate: gridDelegate,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderSliverMasonryGrid renderObject,
  ) {
    renderObject
      ..gridDelegate = gridDelegate
      ..mainAxisSpacing = mainAxisSpacing
      ..crossAxisSpacing = crossAxisSpacing;
  }
}
