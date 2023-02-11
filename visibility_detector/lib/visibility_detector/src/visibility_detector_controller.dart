import 'package:flutter/foundation.dart';

import 'render_visibility_detector.dart';

class VisibilityDetectorController {
  static final _instance = VisibilityDetectorController();
  static VisibilityDetectorController get instance => _instance;

  Duration updateInterval = const Duration(milliseconds: 500);

  void notifyNow() => RenderVisibilityDetectorBase.notifyNow();

  void forget(Key key) => RenderVisibilityDetectorBase.forget(key);

  int? get debugUpdateCount {
    if (!kDebugMode) {
      return null;
    }
    return RenderVisibilityDetectorBase.debugUpdateCount;
  }
}
