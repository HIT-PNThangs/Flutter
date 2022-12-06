import 'package:flutter/widgets.dart';

import '../octo_set.dart';
import 'image_handler.dart';

typedef OctoImageBuilder = Widget Function(BuildContext context, Widget child);
typedef OctoPlaceholderBuilder = Widget Function(BuildContext context);
typedef OctoProgressIndicatorBuilder = Widget Function(
  BuildContext context,
  ImageChunkEvent? progress,
);
typedef OctoErrorBuilder = Widget Function(
  BuildContext context,
  Object error,
  StackTrace? stackTrace,
);

class OctoImage extends StatefulWidget {
  final ImageProvider image;
  final OctoImageBuilder? imageBuilder;
  final OctoPlaceholderBuilder? placeholderBuilder;
  final OctoProgressIndicatorBuilder? progressIndicatorBuilder;
  final OctoErrorBuilder? errorBuilder;
  final Duration placeholderFadeInDuration;
  final Duration fadeOutDuration;
  final Curve fadeOutCurve;
  final Duration fadeInDuration;
  final Curve fadeInCurve;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final AlignmentGeometry alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final Color? color;

  final BlendMode? colorBlendMode;
  final FilterQuality filterQuality;
  final bool gaplessPlayback;

  OctoImage({
    Key? key,
    required ImageProvider image,
    this.imageBuilder,
    this.placeholderBuilder,
    this.progressIndicatorBuilder,
    this.errorBuilder,
    Duration? fadeOutDuration,
    Curve? fadeOutCurve,
    Duration? fadeInDuration,
    Curve? fadeInCurve,
    this.width,
    this.height,
    this.fit,
    Alignment? alignment,
    ImageRepeat? repeat,
    bool? matchTextDirection,
    this.color,
    FilterQuality? filterQuality,
    this.colorBlendMode,
    Duration? placeholderFadeInDuration,
    bool? gaplessPlayback,
    int? memCacheWidth,
    int? memCacheHeight,
  })  : image = ResizeImage.resizeIfNeeded(
          memCacheWidth,
          memCacheHeight,
          image,
        ),
        fadeOutDuration = fadeOutDuration ?? const Duration(milliseconds: 1000),
        fadeOutCurve = fadeOutCurve ?? Curves.easeOut,
        fadeInDuration = fadeInDuration ?? const Duration(milliseconds: 500),
        fadeInCurve = fadeInCurve ?? Curves.easeIn,
        alignment = alignment ?? Alignment.center,
        repeat = repeat ?? ImageRepeat.noRepeat,
        matchTextDirection = matchTextDirection ?? false,
        filterQuality = filterQuality ?? FilterQuality.low,
        placeholderFadeInDuration = placeholderFadeInDuration ?? Duration.zero,
        gaplessPlayback = gaplessPlayback ?? false,
        super(key: key);

  OctoImage.fromSet({
    Key? key,
    required ImageProvider image,
    required OctoSet octoSet,
    Duration? fadeOutDuration,
    Curve? fadeOutCurve,
    Duration? fadeInDuration,
    Curve? fadeInCurve,
    this.width,
    this.height,
    this.fit,
    Alignment? alignment,
    ImageRepeat? repeat,
    bool? matchTextDirection,
    this.color,
    FilterQuality? filterQuality,
    this.colorBlendMode,
    Duration? placeholderFadeInDuration,
    bool? gaplessPlayback,
    int? memCacheWidth,
    int? memCacheHeight,
  })  : image = ResizeImage.resizeIfNeeded(
          memCacheWidth,
          memCacheHeight,
          image,
        ),
        imageBuilder = octoSet.imageBuilder,
        placeholderBuilder = octoSet.placeholderBuilder,
        progressIndicatorBuilder = octoSet.progressIndicatorBuilder,
        errorBuilder = octoSet.errorBuilder,
        fadeOutDuration = fadeOutDuration ?? const Duration(milliseconds: 1000),
        fadeOutCurve = fadeOutCurve ?? Curves.easeOut,
        fadeInDuration = fadeInDuration ?? const Duration(milliseconds: 500),
        fadeInCurve = fadeInCurve ?? Curves.easeIn,
        alignment = alignment ?? Alignment.center,
        repeat = repeat ?? ImageRepeat.noRepeat,
        matchTextDirection = matchTextDirection ?? false,
        filterQuality = filterQuality ?? FilterQuality.low,
        placeholderFadeInDuration = placeholderFadeInDuration ?? Duration.zero,
        gaplessPlayback = gaplessPlayback ?? false,
        super(key: key);

  @override
  _OctoImageState createState() => _OctoImageState();
}

class _OctoImageState extends State<OctoImage> {
  ImageHandler? _previousHandler;
  late ImageHandler _imageHandler;

  @override
  void initState() {
    super.initState();
    _imageHandler = ImageHandler(
      image: widget.image,
      imageBuilder: widget.imageBuilder,
      placeholderBuilder: widget.placeholderBuilder,
      progressIndicatorBuilder: widget.progressIndicatorBuilder,
      errorBuilder: widget.errorBuilder,
      placeholderFadeInDuration: widget.placeholderFadeInDuration,
      fadeOutDuration: widget.fadeOutDuration,
      fadeOutCurve: widget.fadeOutCurve,
      fadeInDuration: widget.fadeInDuration,
      fadeInCurve: widget.fadeInCurve,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      repeat: widget.repeat,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      matchTextDirection: widget.matchTextDirection,
      filterQuality: widget.filterQuality,
      alwaysShowPlaceHolder: false,
    );
  }

  @override
  void didUpdateWidget(OctoImage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.image != widget.image) {
      if (widget.gaplessPlayback) {
        _previousHandler = _imageHandler;
        _previousHandler?.alwaysShowPlaceHolder = false;
      } else {
        _previousHandler = null;
      }
    }
    _imageHandler = ImageHandler(
      image: widget.image,
      imageBuilder: widget.imageBuilder,
      placeholderBuilder: _previousHandler != null ? _previousHandler!.build : widget.placeholderBuilder,
      progressIndicatorBuilder: _previousHandler != null ? null : widget.progressIndicatorBuilder,
      errorBuilder: widget.errorBuilder,
      placeholderFadeInDuration: widget.placeholderFadeInDuration,
      fadeOutDuration: widget.fadeOutDuration,
      fadeOutCurve: widget.fadeOutCurve,
      fadeInDuration: widget.fadeInDuration,
      fadeInCurve: widget.fadeInCurve,
      fit: widget.fit,
      width: widget.width,
      height: widget.height,
      alignment: widget.alignment,
      repeat: widget.repeat,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      matchTextDirection: widget.matchTextDirection,
      filterQuality: widget.filterQuality,
      alwaysShowPlaceHolder: _previousHandler != null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: _imageHandler.build(context),
    );
  }
}
