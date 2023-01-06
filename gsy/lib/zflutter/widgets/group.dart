import 'package:flutter/material.dart';

import '../core/core.dart';

class ZGroup extends ZMultiChildWidget {
  ZGroup({
    super.key,
    required List<Widget> children,
    this.sortMode = SortMode.inherit,
    this.sortPoint,
  })  : assert(sortPoint == null || sortMode == SortMode.update, 'sortPoint can only be used with SortMode.update'),
        super(children: children);

  final SortMode sortMode;

  final ZVector? sortPoint;

  @override
  RenderMultiChildZBox createRenderObject(BuildContext context) {
    return RenderMultiChildZBox(sortMode: sortMode, sortPoint: sortPoint);
  }

  @override
  void updateRenderObject(BuildContext context, RenderMultiChildZBox renderObject) {
    renderObject.sortMode = sortMode;
    renderObject.sortPoint = sortPoint;
  }
}
