import 'package:call_api_air_live/app/data/util/extensions.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'app_colors.dart';

class AppUtil {
  // static void log(String text) {
  //   if (BuildConstants.currentEnvironment != Environment.PROD) {
  //     final pattern = RegExp('.{1,800}');
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
