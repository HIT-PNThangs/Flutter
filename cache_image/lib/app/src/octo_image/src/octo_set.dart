import 'package:flutter/material.dart';

import 'errors.dart';
import 'image/image.dart';
import 'image_transformers.dart';
import 'placeholders.dart';
import 'progress_indicators.dart';

class OctoSet {
  final OctoImageBuilder? imageBuilder;
  final OctoPlaceholderBuilder? placeholderBuilder;
  final OctoProgressIndicatorBuilder? progressIndicatorBuilder;
  final OctoErrorBuilder? errorBuilder;

  OctoSet._({
    this.imageBuilder,
    this.placeholderBuilder,
    this.progressIndicatorBuilder,
    this.errorBuilder,
  }) : assert(placeholderBuilder != null || progressIndicatorBuilder != null);

  factory OctoSet.blurHash(
    String hash, {
    BoxFit? fit,
    Text? errorMessage,
  }) {
    return OctoSet._(
      placeholderBuilder: OctoPlaceholder.blurHash(hash, fit: fit),
      errorBuilder: OctoError.blurHash(hash, fit: fit),
    );
  }

  factory OctoSet.circleAvatar({
    required Color backgroundColor,
    required Widget text,
  }) {
    return OctoSet._(
      placeholderBuilder: OctoPlaceholder.circleAvatar(backgroundColor: backgroundColor, text: text),
      imageBuilder: OctoImageTransformer.circleAvatar(),
      errorBuilder: OctoError.circleAvatar(backgroundColor: backgroundColor, text: text),
    );
  }

  factory OctoSet.circularIndicatorAndIcon({bool showProgress = false}) {
    return OctoSet._(
      placeholderBuilder: showProgress ? null : OctoPlaceholder.circularProgressIndicator(),
      progressIndicatorBuilder: showProgress ? OctoProgressIndicator.circularProgressIndicator() : null,
      errorBuilder: OctoError.icon(),
    );
  }
}
