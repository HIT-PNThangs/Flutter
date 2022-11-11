import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../app/ui/theme/app_colors.dart';

class AppUtil {
  // static void log(String text) {
  //   if (BuildConstants.currentEnvironment != Environment.PROD) {
  //     final pattern = new RegExp('.{1,800}');
  //     pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  //   }
  // }

  static void showToast(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: AppColors.white,
      textColor: AppColors.black,
      fontSize: 16.0.sp,
    );
  }
}
