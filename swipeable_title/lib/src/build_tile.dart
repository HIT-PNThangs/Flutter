import 'package:flutter/material.dart';

import '/src/const/enums.dart';
import 'card_tile.dart';
import 'normal_tile.dart';

const Curve _kResizeTimeCurve = Interval(0.4, 1.0, curve: Curves.ease);
const double _kMinFlingVelocity = 700.0;
const double _kMinFlingVelocityDelta = 400.0;
const double _kFlingVelocityScale = 1.0 / 300.0;

typedef SwipedCallback = void Function(SwipeDirection direction);

typedef ConfirmSwipeCallback = Future<bool?> Function(SwipeDirection direction);

typedef BackgroundBuilder = Widget Function(BuildContext context, SwipeDirection direction, AnimationController progress);

enum _FlingGestureKind { none, forward, reverse }

class SwipeableTile extends StatefulWidget {
  final double horizontalPadding;
  final double verticalPadding;
  final bool isCard;
  final BoxShadow shadow;
  final double borderRadius;
  final Color color;

  final HitTestBehavior behavior;

  final BackgroundBuilder backgroundBuilder;

  final double swipeThreshold;

  final SwipeDirection direction;

  final Duration? resizeDuration;

  final Duration movementDuration;

  final SwipedCallback onSwiped;

  final ConfirmSwipeCallback? confirmSwipe;

  final Widget child;

  final bool swipeToTrigger;

  final bool isElevated;

  const SwipeableTile({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.color,
    required this.onSwiped,
    this.swipeThreshold = 0.4,
    this.confirmSwipe,
    this.borderRadius = 8.0,
    this.direction = SwipeDirection.endToStart,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
    this.isElevated = true,
  })  : isCard = false,
        swipeToTrigger = false,
        horizontalPadding = 0,
        verticalPadding = 1,
        shadow = const BoxShadow(color: Colors.black),
        assert(swipeThreshold > 0.0 && swipeThreshold < 1.0),
        super(key: key);

  const SwipeableTile.card({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.shadow,
    required this.color,
    required this.onSwiped,
    this.borderRadius = 16,
    this.swipeThreshold = 0.4,
    this.confirmSwipe,
    this.direction = SwipeDirection.endToStart,
    this.resizeDuration = const Duration(milliseconds: 300),
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
  })  : isCard = true,
        swipeToTrigger = false,
        isElevated = false,
        assert(swipeThreshold > 0.0 && swipeThreshold < 1.0),
        super(key: key);

  const SwipeableTile.swipeToTrigger({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.color,
    required this.onSwiped,
    this.swipeThreshold = 0.4,
    this.borderRadius = 8.0,
    this.direction = SwipeDirection.endToStart,
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
    this.isElevated = true,
  })  : isCard = false,
        horizontalPadding = 0,
        verticalPadding = 1,
        confirmSwipe = null,
        resizeDuration = null,
        swipeToTrigger = true,
        shadow = const BoxShadow(color: Colors.black),
        assert(swipeThreshold > 0.0 && swipeThreshold <= 0.5),
        super(key: key);

  const SwipeableTile.swipeToTriggerCard({
    required Key key,
    required this.child,
    required this.backgroundBuilder,
    required this.horizontalPadding,
    required this.verticalPadding,
    required this.shadow,
    required this.color,
    required this.onSwiped,
    this.borderRadius = 16,
    this.swipeThreshold = 0.4,
    this.direction = SwipeDirection.endToStart,
    this.movementDuration = const Duration(milliseconds: 200),
    this.behavior = HitTestBehavior.opaque,
  })  : isCard = true,
        swipeToTrigger = true,
        confirmSwipe = null,
        isElevated = false,
        resizeDuration = null,
        assert(swipeThreshold > 0.0 && swipeThreshold <= 0.5),
        super(key: key);

  @override
  _SwipeableTileState createState() => _SwipeableTileState();
}

class _SwipeableTileState extends State<SwipeableTile> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  AnimationController? _moveController;
  late Animation<Offset> _moveAnimation;

  AnimationController? _resizeController;
  Animation<double>? _resizeAnimation;

  double _dragExtent = 0.0;
  bool _dragUnderway = false;
  Size? _sizePriorToCollapse;

  @override
  void initState() {
    super.initState();
    _moveController = AnimationController(duration: widget.movementDuration, vsync: this)
      ..addStatusListener(_handleDismissStatusChanged);

    _updateMoveAnimation();
  }

  @override
  bool get wantKeepAlive => _moveController?.isAnimating == true || _resizeController?.isAnimating == true;

  SwipeDirection _extentToDirection(double extent) {
    if (extent == 0.0) return SwipeDirection.none;
    switch (Directionality.of(context)) {
      case TextDirection.rtl:
        return extent < 0 ? SwipeDirection.startToEnd : SwipeDirection.endToStart;
      case TextDirection.ltr:
        return extent > 0 ? SwipeDirection.startToEnd : SwipeDirection.endToStart;
    }
  }

  SwipeDirection get _swipeDirection => _extentToDirection(_dragExtent);

  bool get _isActive {
    return _dragUnderway || _moveController!.isAnimating;
  }

  double get _overallDragAxisExtent {
    final Size size = context.size!;
    final double threshold = widget.swipeThreshold;

    return widget.swipeToTrigger ? size.width * threshold : size.width;
  }

  void _handleDragStart(DragStartDetails details) {
    _dragUnderway = true;
    if (_moveController!.isAnimating) {
      _dragExtent = _moveController!.value * _overallDragAxisExtent * _dragExtent.sign;
      _moveController!.stop();
    } else {
      _dragExtent = 0.0;
      _moveController!.value = 0.0;
    }
    setState(() {
      _updateMoveAnimation();
    });
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!_isActive || _moveController!.isAnimating) return;

    final double delta = details.primaryDelta!;
    final double oldDragExtent = _dragExtent;
    switch (widget.direction) {
      case SwipeDirection.horizontal:
        _dragExtent += delta;
        break;

      case SwipeDirection.endToStart:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta > 0) _dragExtent += delta;
            break;
          case TextDirection.ltr:
            if (_dragExtent + delta < 0) _dragExtent += delta;
            break;
        }
        break;

      case SwipeDirection.startToEnd:
        switch (Directionality.of(context)) {
          case TextDirection.rtl:
            if (_dragExtent + delta < 0) _dragExtent += delta;
            break;
          case TextDirection.ltr:
            if (_dragExtent + delta > 0) _dragExtent += delta;
            break;
        }
        break;

      case SwipeDirection.none:
        _dragExtent = 0;
        break;
    }
    if (oldDragExtent.sign != _dragExtent.sign) {
      setState(() {
        _updateMoveAnimation();
      });
    }

    if (!_moveController!.isAnimating) {
      _moveController!.value = _dragExtent.abs() / _overallDragAxisExtent;
    }
  }

  void _updateMoveAnimation() {
    final double end = _dragExtent.sign;
    final double endOffsetX = widget.swipeToTrigger ? end * widget.swipeThreshold : end;

    _moveAnimation = _moveController!.drive(
      Tween<Offset>(
        begin: Offset.zero,
        end: Offset(endOffsetX, 0),
      ),
    );
  }

  _FlingGestureKind _describeFlingGesture(Velocity velocity) {
    if (_dragExtent == 0.0) {
      // If it was a fling, then it was a fling that was let loose at the exact
      // middle of the range (i.e. when there's no displacement). In that case,
      // we assume that the user meant to fling it back to the center, as
      // opposed to having wanted to drag it out one way, then fling it past the
      // center and into and out the other side.
      return _FlingGestureKind.none;
    }
    final double vx = velocity.pixelsPerSecond.dx;
    final double vy = velocity.pixelsPerSecond.dy;
    SwipeDirection flingDirection;
    // Verify that the fling is in the generally right direction and fast enough.
    if (vx.abs() - vy.abs() < _kMinFlingVelocityDelta || vx.abs() < _kMinFlingVelocity) return _FlingGestureKind.none;
    assert(vx != 0.0);
    flingDirection = _extentToDirection(vx);

    if (flingDirection == _swipeDirection) return _FlingGestureKind.forward;
    return _FlingGestureKind.reverse;
  }

  Future<void> _handleDragEnd(DragEndDetails details) async {
    if (!_isActive || _moveController!.isAnimating) return;
    _dragUnderway = false;
    if (_moveController!.isCompleted && await _confirmStartResizeAnimation() == true) {
      if (widget.swipeToTrigger) {
        _handleSwipeToTriggerAnimation();
      } else {
        _startResizeAnimation();
      }

      return;
    }

    final double flingVelocity = details.velocity.pixelsPerSecond.dx;

    switch (_describeFlingGesture(details.velocity)) {
      case _FlingGestureKind.forward:
        assert(_dragExtent != 0.0);
        assert(!_moveController!.isDismissed);
        if ((widget.swipeThreshold) >= 1.0) {
          _moveController!.reverse();
          break;
        }
        _dragExtent = flingVelocity.sign;
        _moveController!.fling(velocity: flingVelocity.abs() * _kFlingVelocityScale);
        break;
      case _FlingGestureKind.reverse:
        assert(_dragExtent != 0.0);
        assert(!_moveController!.isDismissed);
        _dragExtent = flingVelocity.sign;
        _moveController!.fling(velocity: -flingVelocity.abs() * _kFlingVelocityScale);
        break;
      case _FlingGestureKind.none:
        if (!_moveController!.isDismissed) {
          // we already know it's not completed, we check that above
          if (_moveController!.value > (widget.swipeThreshold)) {
            if (widget.swipeToTrigger) {
              _moveController!.reverse();
            } else {
              _moveController!.forward();
            }
          } else {
            _moveController!.reverse();
          }
        }
        break;
    }
  }

  Future<void> _handleDismissStatusChanged(AnimationStatus status) async {
    if (status == AnimationStatus.completed && !_dragUnderway) {
      if (widget.swipeToTrigger) {
        // final SwipeDirection direction = _swipeDirection;
        // widget.onSwiped(direction);
        // _moveController!.reverse();
        _handleSwipeToTriggerAnimation();
      } else if (status == AnimationStatus.completed && !_dragUnderway) {
        if (await _confirmStartResizeAnimation() == true) {
          _startResizeAnimation();
        } else {
          _moveController!.reverse();
        }
      }
    }

    updateKeepAlive();
  }

  Future<bool?> _confirmStartResizeAnimation() async {
    if (widget.confirmSwipe != null) {
      final SwipeDirection direction = _swipeDirection;
      return widget.confirmSwipe!(direction);
    }
    return true;
  }

  void _handleSwipeToTriggerAnimation() async {
    await _moveController!.reverse();
    final SwipeDirection direction = _swipeDirection;
    widget.onSwiped(direction);
  }

  void _startResizeAnimation() {
    assert(_moveController != null);
    assert(_moveController!.isCompleted);
    assert(_resizeController == null);
    assert(_sizePriorToCollapse == null);
    // if (widget.swipeToTrigger) {
    //   final SwipeDirection direction = _swipeDirection;
    //   if (_moveController!.status == AnimationStatus.dismissed) {
    //     widget.onSwiped(direction);
    //   }
    // } else {
    _resizeController = AnimationController(duration: widget.resizeDuration, vsync: this)
      ..addListener(_handleResizeProgressChanged)
      ..addStatusListener((AnimationStatus status) => updateKeepAlive());
    _resizeController!.forward();
    setState(() {
      _sizePriorToCollapse = context.size;
      _resizeAnimation = _resizeController!
          .drive(
            CurveTween(
              curve: _kResizeTimeCurve,
            ),
          )
          .drive(
            Tween<double>(
              begin: 1.0,
              end: 0.0,
            ),
          );
    });
    // }
  }

  void _handleResizeProgressChanged() {
    if (_resizeController!.isCompleted) {
      widget.onSwiped.call(_swipeDirection);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget buildBackground = widget.backgroundBuilder(context, _swipeDirection, _moveController!);
    final SwipeDirection direction = widget.direction;
    final EdgeInsetsGeometry padding = EdgeInsets.symmetric(
      horizontal: widget.horizontalPadding,
      vertical: widget.verticalPadding,
    );
    final bool isCard = widget.isCard;
    final BoxShadow shadow = widget.shadow;
    final double borderRadius = widget.borderRadius;
    final Color color = widget.color;
    final bool isElevated = widget.isElevated;

    super.build(context); // See AutomaticKeepAliveClientMixin.

    assert(debugCheckHasDirectionality(context));

    if (_resizeAnimation != null) {
      // we've been dragged aside, and are now resizing.
      assert(() {
        if (_resizeAnimation!.status != AnimationStatus.forward) {
          assert(_resizeAnimation!.status == AnimationStatus.completed);
          throw FlutterError.fromParts(<DiagnosticsNode>[
            ErrorSummary('A swiped SwipeableTile widget is still part of the tree.'),
            ErrorHint(
              'Make sure to implement the onSwiped handler and to immediately remove the SwipeableTile '
              'widget from the application once that handler has fired.',
            ),
          ]);
        }
        return true;
      }());

      return SizeTransition(
        sizeFactor: _resizeAnimation!,
        axis: Axis.vertical,
        child: Container(
          padding: padding,
          width: _sizePriorToCollapse!.width,
          height: _sizePriorToCollapse!.height,
          child: ClipRRect(
            borderRadius: isCard ? BorderRadius.circular(borderRadius) : BorderRadius.zero,
            child: buildBackground,
          ),
        ),
      );
    }

    Widget content = isCard
        ? CardTile(
            moveAnimation: _moveAnimation,
            controller: _moveController!,
            background: buildBackground,
            direction: direction,
            padding: padding,
            shadow: shadow,
            borderRadius: borderRadius,
            color: color,
            child: widget.child,
          )
        : NormalTile(
            moveAnimation: _moveAnimation,
            controller: _moveController!,
            background: buildBackground,
            direction: direction,
            padding: padding,
            borderRadius: borderRadius,
            color: color,
            isElevated: isElevated,
            child: widget.child,
          );
    return GestureDetector(
      onHorizontalDragStart: _handleDragStart,
      onHorizontalDragUpdate: _handleDragUpdate,
      onHorizontalDragEnd: _handleDragEnd,
      behavior: widget.behavior,
      child: content,
    );
  }

  @override
  void dispose() {
    _moveController!.dispose();
    _resizeController?.dispose();
    super.dispose();
  }
}
