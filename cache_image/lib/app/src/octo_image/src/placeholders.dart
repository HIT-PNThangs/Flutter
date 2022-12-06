import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

import 'image/image.dart';

class OctoPlaceholder {
  static OctoPlaceholderBuilder blurHash(String hash, {BoxFit? fit}) {
    return (context) => SizedBox.expand(
          child: Image(
            image: BlurHashImage(hash),
            fit: fit ?? BoxFit.cover,
          ),
        );
  }

  static OctoPlaceholderBuilder circleAvatar({
    required Color backgroundColor,
    required Widget text,
  }) {
    return (context) => SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: CircleAvatar(
            backgroundColor: backgroundColor,
            child: text,
          ),
        );
  }

  static OctoPlaceholderBuilder circularProgressIndicator() {
    return (context) => const Center(
          child: CircularProgressIndicator(),
        );
  }

  static OctoPlaceholderBuilder frame() {
    return (context) => const SizedBox.expand(child: Placeholder());
  }
}
