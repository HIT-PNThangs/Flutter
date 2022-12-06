import 'package:flutter/material.dart';

import 'image/image.dart';

class OctoImageTransformer {
  static OctoImageBuilder circleAvatar() {
    return (context, child) => Center(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: ClipOval(
              child: child,
            ),
          ),
        );
  }
}
