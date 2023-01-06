import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../core.dart';
import '../widgets/update_parent_data.dart';

class ZTransform {
  ZVector rotate;
  ZVector translate;
  ZVector scale;

  ZTransform({this.rotate = ZVector.zero, this.translate = ZVector.zero, this.scale = ZVector.identity});
}

class ZPositioned extends ZUpdateParentDataWidget<ZParentData> with ZWidget {
  const ZPositioned({
    Key? key,
    this.scale = ZVector.identity,
    this.translate = ZVector.zero,
    this.rotate = ZVector.zero,
    required Widget child,
  }) : super(key: key, child: child);

  ZPositioned.scale({
    Key? key,
    double x = 1,
    double y = 1,
    double z = 1,
    required Widget child,
  })  : scale = ZVector(x, y, z),
        rotate = ZVector.zero,
        translate = ZVector.zero,
        super(key: key, child: child);

  ZPositioned.translate({
    Key? key,
    double x = 0,
    double y = 0,
    double z = 0,
    required Widget child,
  })  : scale = ZVector.identity,
        rotate = ZVector.zero,
        translate = ZVector(x, y, z),
        super(key: key, child: child);

  ZPositioned.rotate({
    Key? key,
    double x = 0,
    double y = 0,
    double z = 0,
    required Widget child,
  })  : scale = ZVector.identity,
        rotate = ZVector(x, y, z),
        translate = ZVector.zero,
        super(key: key, child: child);

  // Transformation vector that translates its child in a 3D space
  final ZVector translate;

  // Transformation vector that rotates its child in a 3D space.
  final ZVector rotate;

  // Transformation vector that scale its child in a 3D space.
  // Notice that this param won't scale the stroke of the [ZShape]
  // widgets and will only transform its path
  final ZVector scale;

  @override
  void updateParentData(RenderObject renderObject, ZPositioned oldWidget, ZTransform transform) {
    assert(renderObject.parentData is ZParentData);

    bool needsLayout = false;

    transform.scale = scale;
    transform.rotate = rotate;
    transform.translate = translate;

    if (scale != oldWidget.scale || rotate != oldWidget.rotate || translate != oldWidget.translate) {
      needsLayout = true;
    }

    if (renderObject is RenderMultiChildZBox) {
      RenderZBox? child = renderObject.firstChild;

      while (child != null) {
        final ZParentData childParentData = child.parentData as ZParentData;
        updateParentData(child, oldWidget, transform);
        child = childParentData.nextSibling;
      }
    }

    if (needsLayout) {
      renderObject.markNeedsLayout();
      AbstractNode? targetParent = renderObject.parent;

      while (targetParent is RenderZBox) {
        targetParent.markNeedsLayout();
        targetParent = targetParent.parent;
      }
    }
  }

  @override
  Type get debugTypicalAncestorWidgetClass => ZWidget;

  @override
  void startParentData(RenderObject renderObject, ZTransform transform) {
    assert(renderObject.parentData is ZParentData);
    final ZParentData parentData = renderObject.parentData as ZParentData;
    // print('crate matrix');
    transform.scale = scale;
    transform.translate = translate;
    transform.rotate = rotate;

    parentData.transforms.add(transform);

    if (renderObject is RenderMultiChildZBox) {
      RenderZBox? child = renderObject.firstChild;

      while (child != null) {
        final ZParentData childParentData = child.parentData as ZParentData;
        startParentData(child, transform);
        child = childParentData.nextSibling;
      }
    }

    final AbstractNode? targetParent = renderObject.parent;
    if (targetParent is RenderObject) targetParent.markNeedsLayout();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
  }
}
