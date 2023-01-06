import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'positioned.dart';

abstract class ZUpdateParentDataWidget<T extends ParentData> extends ProxyWidget {
  const ZUpdateParentDataWidget({Key? key, required Widget child}) : super(key: key, child: child);

  @override
  UpdateParentDataElement<T> createElement() => UpdateParentDataElement<T>(this);

  bool debugIsValidRenderObject(RenderObject renderObject) {
    assert(T != dynamic);
    assert(T != ParentData);
    return renderObject.parentData is T;
  }

  Type get debugTypicalAncestorWidgetClass;

  @protected
  void updateParentData(RenderObject renderObject, covariant ZUpdateParentDataWidget<T> oldWidget, ZTransform transform);

  @protected
  void startParentData(RenderObject renderObject, ZTransform transform);

  @protected
  bool debugCanApplyOutOfTurn() => false;
}

class UpdateParentDataElement<T extends ParentData> extends ProxyElement {
  UpdateParentDataElement(ZUpdateParentDataWidget<T> widget) : super(widget);

  @override
  ZUpdateParentDataWidget<T> get widget => super.widget as ZUpdateParentDataWidget<T>;

  ZTransform transform = ZTransform();

  void _updateParentData(ZUpdateParentDataWidget<T> widget, ZUpdateParentDataWidget<T> oldWidget) {
    void applyParentDataToChild(Element child) {
      if (child is RenderObjectElement) {
        widget.updateParentData(child.renderObject, oldWidget, transform);
      } else {
        child.visitChildren(applyParentDataToChild);
      }
    }

    visitChildren(applyParentDataToChild);
  }

  void startParentData(RenderObject renderObject) {
    widget.startParentData(renderObject, transform);
  }

  void applyWidgetOutOfTurn(ZUpdateParentDataWidget<T> newWidget) {
    assert(newWidget.debugCanApplyOutOfTurn());
    assert(newWidget.child == widget.child);
    _updateParentData(newWidget, widget);
  }

  @override
  void notifyClients(ZUpdateParentDataWidget<T> oldWidget) {
    _updateParentData(widget, oldWidget);
  }
}
