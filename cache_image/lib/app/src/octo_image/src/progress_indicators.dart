import 'package:flutter/material.dart';

import 'image/image.dart';

class OctoProgressIndicator {
  static OctoProgressIndicatorBuilder circularProgressIndicator() {
    return (context, progress) {
      double? value;
      if (progress != null && progress.expectedTotalBytes != null) {
        value = progress.cumulativeBytesLoaded / progress.expectedTotalBytes!;
      }
      return Center(child: CircularProgressIndicator(value: value));
    };
  }
}
