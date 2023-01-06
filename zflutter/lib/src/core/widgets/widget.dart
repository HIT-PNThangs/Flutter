import 'package:flutter/material.dart';

import '../core.dart';
import 'update_parent_data.dart';

mixin ZWidget on Widget {}

class ZSingleChildRenderObjectElement extends SingleChildRenderObjectElement {
  ZSingleChildRenderObjectElement(SingleChildRenderObjectWidget widget) : super(widget);

  @override
  void attachRenderObject(newSlot) {
    super.attachRenderObject(newSlot);

    visitAncestorElements((element) {
      if (element is UpdateParentDataElement<ZParentData>) {
        element.startParentData(renderObject);
      }
      return element.widget is! RenderObjectWidget;
    });
  }
}

abstract class ZMultiChildWidget extends MultiChildRenderObjectWidget with ZWidget {
  ZMultiChildWidget({super.key, required List<Widget> children}) : super(children: children);

  @override
  RenderMultiChildZBox createRenderObject(BuildContext context) {
    return RenderMultiChildZBox();
  }

  @override
  void updateRenderObject(BuildContext context, RenderMultiChildZBox renderObject) {}

  @override
  ZMultiChildRenderObjectElement createElement() => ZMultiChildRenderObjectElement(this);
}

class ZMultiChildRenderObjectElement extends MultiChildRenderObjectElement {
  ZMultiChildRenderObjectElement(MultiChildRenderObjectWidget widget)
      : assert(!debugChildrenHaveDuplicateKeys(widget, widget.children)),
        super(widget);

  @override
  void attachRenderObject(newSlot) {
    super.attachRenderObject(newSlot);

    visitAncestorElements((element) {
      if (element is UpdateParentDataElement<ZParentData>) {
        element.startParentData(renderObject);
      }
      return element.widget is! RenderObjectWidget;
    });
  }
}
