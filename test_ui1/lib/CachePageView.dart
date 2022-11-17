import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class MyViewPort extends RenderSliverFillViewport {
  int itemCount;

  MyViewPort({
    RenderSliverBoxChildManager? childManager,
    double viewportFraction = 1.0,
    required this.itemCount
  }) : super(childManager: childManager!, viewportFraction: viewportFraction);

  @override
  int getMaxChildIndexForScrollOffset(double scrollOffset, double itemExtent) {
    return min(
        super.getMaxChildIndexForScrollOffset(scrollOffset, itemExtent) + 2,
        itemCount - 1);
  }

  @override
  void setupParentData(RenderObject child) {
    if (child.parentData is! SliverMultiBoxAdaptorParentData) {
      child.parentData = SliverMultiBoxAdaptorParentData()..keepAlive = true;
    }
  }
}

class MySliverFillViewport extends SliverMultiBoxAdaptorWidget {
  /// Creates a sliver whose box children that each fill the viewport.
  //
  const MySliverFillViewport(
      {Key? key,
      required SliverChildDelegate delegate,
      this.viewportFraction = 1.0,
      required this.itemCount})
      : assert(viewportFraction > 0.0),
        super(key: key, delegate: delegate);

  /// The fraction of the viewport that each child should fill in the main axis.
  ///
  /// If this fraction is less than 1.0, more than one child will be visible at
  /// once. If this fraction is greater than 1.0, each child will be larger than
  /// the viewport in the main axis.
  final double viewportFraction;

  final int itemCount;

  @override
  RenderSliverFillViewport createRenderObject(BuildContext context) {
    return MyViewPort(
        itemCount: itemCount,
        viewportFraction: viewportFraction);
  }

  @override
  SliverMultiBoxAdaptorElement createElement() {
    return SliverMultiBoxAdaptorElement(this);
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderSliverFillViewport renderObject) {
    renderObject.viewportFraction = viewportFraction;
  }
}

const PageScrollPhysics _kPagePhysics = PageScrollPhysics();

class Ext extends PageView {
  Ext({super.key});
}

class MyPageView extends StatelessWidget {
  final SliverChildListDelegate childrenDelegate;

  MyPageView({super.key, required List<Widget> children})
      : childrenDelegate = SliverChildListDelegate(children);

  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scrollable(
      axisDirection: AxisDirection.right,
      controller: controller,
      physics: _kPagePhysics,
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        print(position);
        return Viewport(
          cacheExtent: 300.0,
          axisDirection: AxisDirection.right,
          offset: position,
          slivers: <Widget>[
            MySliverFillViewport(
                viewportFraction: 1.0,
                itemCount: 10,
                delegate: childrenDelegate),
          ],
        );
      },
    );
  }
}
