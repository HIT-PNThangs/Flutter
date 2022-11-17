import 'package:flutter/material.dart';

import 'transform_info.dart';

abstract class PageTransformer {
  final bool reverse;

  PageTransformer({this.reverse = false});

  /// Return a transformed widget, based on child and TransformInfo
  Widget transform(Widget child, TransformInfo info);
}

typedef PageTransformerBuilderCallback = Widget Function(
    Widget child, TransformInfo info);

class PageTransformerBuilder extends PageTransformer {
  final PageTransformerBuilderCallback builder;

  PageTransformerBuilder({bool reverse = false, required this.builder})
      : super(reverse: reverse);

  @override
  Widget transform(Widget child, TransformInfo info) {
    return builder(child, info);
  }
}
