import 'package:flutter/widgets.dart';

import '../core.dart';
import '../render/render_box_adapter.dart';

class ZToBoxAdapter extends SingleChildRenderObjectWidget with ZWidget {
  final double height;
  final double width;

  const ZToBoxAdapter({
    Key? key,
    required this.height,
    required this.width,
    Widget? child,
  }) : super(key: key, child: child);

  @override
  RenderZToBoxAdapter createRenderObject(BuildContext context) => RenderZToBoxAdapter(height: height, width: width);

  @override
  void updateRenderObject(BuildContext context, RenderZToBoxAdapter renderObject) {
    renderObject.height = height;
    renderObject.width = width;
    super.updateRenderObject(context, renderObject);
  }

  @override
  ZSingleChildRenderObjectElement createElement() => ZSingleChildRenderObjectElement(this);
}
