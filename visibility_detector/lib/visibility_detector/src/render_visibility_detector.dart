import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';

import 'visibility_detector.dart';
import 'visibility_detector_controller.dart';

mixin RenderVisibilityDetectorBase on RenderObject {
  static int? get debugUpdateCount {
    if (!kDebugMode) {
      return null;
    }
    return _updates.length;
  }

  static final Map<Key, VoidCallback> _updates = <Key, VoidCallback>{};
  static final Map<Key, VisibilityInfo> _lastVisibility = <Key, VisibilityInfo>{};

  /// See [VisibilityDetectorController.notifyNow].
  static void notifyNow() {
    _timer?.cancel();
    _timer = null;
    _processCallbacks();
  }

  static void forget(Key key) {
    _updates.remove(key);
    _lastVisibility.remove(key);

    if (_updates.isEmpty) {
      _timer?.cancel();
      _timer = null;
    }
  }

  static Timer? _timer;

  static void _handleTimer() {
    _timer = null;
    SchedulerBinding.instance.scheduleTask<void>(
      _processCallbacks,
      Priority.touch,
    );
  }

  static void _processCallbacks() {
    for (final callback in _updates.values) {
      callback();
    }
    _updates.clear();
  }

  void _fireCallback(ContainerLayer? layer, Rect bounds) {
    final oldInfo = _lastVisibility[key];
    final info = _determineVisibility(layer, bounds);
    final visible = !info.visibleBounds.isEmpty;

    if (oldInfo == null) {
      if (!visible) {
        return;
      }
    } else if (info.matchesVisibility(oldInfo)) {
      return;
    }

    if (visible) {
      _lastVisibility[key] = info;
    } else {
      _lastVisibility.remove(key);
    }

    onVisibilityChanged?.call(info);
  }

  Key get key;

  VoidCallback? _compositionCallbackCanceller;

  VisibilityChangedCallback? _onVisibilityChanged;

  VisibilityChangedCallback? get onVisibilityChanged => _onVisibilityChanged;

  set onVisibilityChanged(VisibilityChangedCallback? value) {
    if (_onVisibilityChanged == value) {
      return;
    }
    _compositionCallbackCanceller?.call();
    _compositionCallbackCanceller = null;
    _onVisibilityChanged = value;

    if (value == null) {
      forget(key);
    } else {
      markNeedsPaint();
      _scheduleUpdate();
    }
  }

  int _debugScheduleUpdateCount = 0;

  @visibleForTesting
  int? get debugScheduleUpdateCount {
    if (kDebugMode) {
      return _debugScheduleUpdateCount;
    }
    return null;
  }

  void _scheduleUpdate([ContainerLayer? layer]) {
    if (kDebugMode) {
      _debugScheduleUpdateCount += 1;
    }
    bool isFirstUpdate = _updates.isEmpty;
    _updates[key] = () {
      if (bounds == null) {
        return;
      }
      _fireCallback(layer, bounds!);
    };
    final updateInterval = VisibilityDetectorController.instance.updateInterval;
    if (updateInterval == Duration.zero) {
      if (isFirstUpdate) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          _processCallbacks();
        });
      }
    } else if (_timer == null) {
      _timer = Timer(updateInterval, _handleTimer);
    } else {
      assert(_timer!.isActive);
    }
  }

  VisibilityInfo _determineVisibility(ContainerLayer? layer, Rect bounds) {
    if (_disposed || layer == null || layer.attached == false || !attached) {
      return VisibilityInfo(
        key: key,
        size: _lastVisibility[key]?.size ?? Size.zero,
      );
    }
    final transform = Matrix4.identity();

    if (parent != null) {
      RenderObject ancestor = parent! as RenderObject;
      RenderObject child = this;
      while (ancestor.parent != null) {
        if (!ancestor.paintsChild(child)) {
          return VisibilityInfo(key: key, size: bounds.size);
        }
        child = ancestor;
        ancestor = ancestor.parent! as RenderObject;
      }
    }

    ContainerLayer? ancestor = layer;
    final List<ContainerLayer> ancestors = <ContainerLayer>[ContainerLayer()];
    while (ancestor != null && ancestor.parent != null) {
      ancestors.add(ancestor);
      ancestor = ancestor.parent;
    }

    Rect clip = Rect.largest;
    for (int index = ancestors.length - 1; index > 0; index -= 1) {
      final parent = ancestors[index];
      final child = ancestors[index - 1];
      Rect? parentClip = parent.describeClipBounds();
      if (parentClip != null) {
        clip = clip.intersect(MatrixUtils.transformRect(transform, parentClip));
      }
      parent.applyTransform(child, transform);
    }

    if (_lastPaintClipBounds != null) {
      clip = clip.intersect(MatrixUtils.transformRect(
        transform,
        _lastPaintClipBounds!,
      ));
    }
    if (_lastPaintTransform != null) {
      transform.multiply(_lastPaintTransform!);
    }
    return VisibilityInfo.fromRects(
      key: key,
      widgetBounds: MatrixUtils.transformRect(transform, bounds),
      clipRect: clip,
    );
  }

  Rect? get bounds;

  Matrix4? _lastPaintTransform;
  Rect? _lastPaintClipBounds;

  @override
  void paint(PaintingContext context, Offset offset) {
    if (onVisibilityChanged != null) {
      _lastPaintClipBounds = context.canvas.getLocalClipBounds();
      _lastPaintTransform = Matrix4.fromFloat64List(context.canvas.getTransform())..translate(offset.dx, offset.dy, 0);

      _compositionCallbackCanceller?.call();
      _compositionCallbackCanceller = context.addCompositionCallback((Layer layer) {
        assert(!debugDisposed!);
        final ContainerLayer? container = layer is ContainerLayer ? layer : layer.parent;
        _scheduleUpdate(container);
      });
    }
    super.paint(context, offset);
  }

  bool _disposed = false;

  @override
  void dispose() {
    _compositionCallbackCanceller?.call();
    _compositionCallbackCanceller = null;
    _disposed = true;
    super.dispose();
  }
}

class RenderVisibilityDetector extends RenderProxyBox with RenderVisibilityDetectorBase {
  RenderVisibilityDetector({
    RenderBox? child,
    required this.key,
    required VisibilityChangedCallback? onVisibilityChanged,
  }) : super(child) {
    _onVisibilityChanged = onVisibilityChanged;
  }

  @override
  final Key key;

  @override
  Rect? get bounds => hasSize ? semanticBounds : null;
}

class RenderSliverVisibilityDetector extends RenderProxySliver with RenderVisibilityDetectorBase {
  RenderSliverVisibilityDetector({
    RenderSliver? sliver,
    required this.key,
    required VisibilityChangedCallback? onVisibilityChanged,
  }) : super(sliver) {
    _onVisibilityChanged = onVisibilityChanged;
  }

  @override
  final Key key;

  @override
  Rect? get bounds {
    if (geometry == null) {
      return null;
    }

    Size widgetSize;
    Offset widgetOffset;
    switch (applyGrowthDirectionToAxisDirection(
      constraints.axisDirection,
      constraints.growthDirection,
    )) {
      case AxisDirection.down:
        widgetOffset = Offset(0, -constraints.scrollOffset);
        widgetSize = Size(constraints.crossAxisExtent, geometry!.scrollExtent);
        break;
      case AxisDirection.up:
        final startOffset = geometry!.paintExtent + constraints.scrollOffset - geometry!.scrollExtent;
        widgetOffset = Offset(0, math.min(startOffset, 0));
        widgetSize = Size(constraints.crossAxisExtent, geometry!.scrollExtent);
        break;
      case AxisDirection.right:
        widgetOffset = Offset(-constraints.scrollOffset, 0);
        widgetSize = Size(geometry!.scrollExtent, constraints.crossAxisExtent);
        break;
      case AxisDirection.left:
        final startOffset = geometry!.paintExtent + constraints.scrollOffset - geometry!.scrollExtent;
        widgetOffset = Offset(math.min(startOffset, 0), 0);
        widgetSize = Size(geometry!.scrollExtent, constraints.crossAxisExtent);
        break;
    }
    return widgetOffset & widgetSize;
  }
}
