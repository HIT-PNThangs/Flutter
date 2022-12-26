import 'package:flutter/cupertino.dart';

import 'default_colors.dart';

class ContentType {
  final String message;
  final Color? color;

  ContentType(this.message, [this.color]);

  static ContentType help = ContentType('help', DefaultColors.helpBlue);
  static ContentType failure = ContentType('failure', DefaultColors.failureRed);
  static ContentType success =
      ContentType('success', DefaultColors.successGreen);
  static ContentType warning =
      ContentType('warning', DefaultColors.warningYellow);
}
