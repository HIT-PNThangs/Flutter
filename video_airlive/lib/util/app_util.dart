import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_airlive/util/extensions.dart';

import '../app/ui/theme/app_colors.dart';

class AppUtil {
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
