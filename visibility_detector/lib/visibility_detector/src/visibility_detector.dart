import 'dart:math' show max;

import 'package:flutter/widgets.dart';

import 'render_visibility_detector.dart';

class VisibilityDetector extends SingleChildRenderObjectWidget {
  const VisibilityDetector({
    required Key key,
    required Widget child,
    required this.onVisibilityChanged,
  }) : super(key: key, child: child);

  final VisibilityChangedCallback? onVisibilityChanged;

  @override
  RenderVisibilityDetector createRenderObject(BuildContext context) {
    return RenderVisibilityDetector(
      key: key!,
      onVisibilityChanged: onVisibilityChanged,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderVisibilityDetector renderObject) {
    assert(renderObject.key == key);
    renderObject.onVisibilityChanged = onVisibilityChanged;
  }
}

class SliverVisibilityDetector extends SingleChildRenderObjectWidget {
  const SliverVisibilityDetector({
    required Key key,
    required Widget sliver,
    required this.onVisibilityChanged,
  }) : super(key: key, child: sliver);

  final VisibilityChangedCallback? onVisibilityChanged;

  @override
  RenderSliverVisibilityDetector createRenderObject(BuildContext context) {
    return RenderSliverVisibilityDetector(
      key: key!,
      onVisibilityChanged: onVisibilityChanged,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderSliverVisibilityDetector renderObject) {
    assert(renderObject.key == key);
    renderObject.onVisibilityChanged = onVisibilityChanged;
  }
}

typedef VisibilityChangedCallback = void Function(VisibilityInfo info);

@immutable
class VisibilityInfo {
  const VisibilityInfo({
    required this.key,
    this.size = Size.zero,
    this.visibleBounds = Rect.zero,
  });

  factory VisibilityInfo.fromRects({
    required Key key,
    required Rect widgetBounds,
    required Rect clipRect,
  }) {
    final bool overlaps = widgetBounds.overlaps(clipRect);
    final visibleBounds = overlaps ? widgetBounds.intersect(clipRect).shift(-widgetBounds.topLeft) : Rect.zero;

    return VisibilityInfo(
      key: key,
      size: widgetBounds.size,
      visibleBounds: visibleBounds,
    );
  }

  final Key key;

  final Size size;

  final Rect visibleBounds;

  double get visibleFraction {
    final visibleArea = _area(visibleBounds.size);
    final maxVisibleArea = _area(size);

    if (_floatNear(maxVisibleArea, 0)) {
      return 0;
    }

    var visibleFraction = visibleArea / maxVisibleArea;

    if (_floatNear(visibleFraction, 0)) {
      visibleFraction = 0;
    } else if (_floatNear(visibleFraction, 1)) {
      visibleFraction = 1;
    }

    assert(visibleFraction >= 0);
    assert(visibleFraction <= 1);
    return visibleFraction;
  }

  bool matchesVisibility(VisibilityInfo info) {
    return size == info.size && visibleBounds == info.visibleBounds;
  }

  @override
  String toString() {
    return 'VisibilityInfo(key: $key, size: $size visibleBounds: $visibleBounds)';
  }

  @override
  int get hashCode => Object.hash(key, size, visibleBounds);

  @override
  bool operator ==(Object other) {
    return other is VisibilityInfo && other.key == key && other.size == size && other.visibleBounds == visibleBounds;
  }
}

const _kDefaultTolerance = 0.01;

double _area(Size size) {
  assert(size.width >= 0);
  assert(size.height >= 0);
  return size.width * size.height;
}

bool _floatNear(double f1, double f2) {
  final absDiff = (f1 - f2).abs();
  return absDiff <= _kDefaultTolerance || (absDiff / max(f1.abs(), f2.abs()) <= _kDefaultTolerance);
}
