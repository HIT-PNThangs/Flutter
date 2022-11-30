import 'package:airlive/app/ui/loading/easy_loading.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

import '../../util/app_util.dart';
import '../route/app_pages.dart';

class SelectedImageController extends GetxController {
  RxString link = ''.obs;

  RxString strTime = "".obs;
  RxString strDay = "".obs;

  RxBool review = true.obs;

  @override
  void onInit() {
    super.onInit();

    link.value = Get.arguments['link'];

    getTime();
  }

  getTime() {
    List days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
    List months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];

    final DateTime time = DateTime.now();

    final int hour = time.hour;
    final int minute = time.minute;

    final int day = time.weekday;
    final int month = time.month;
    final int dayInMonth = time.day;

    strTime.value = "${hour < 10 ? '0$hour' : '$hour'} : ${minute < 10 ? '0$minute' : '$minute'}";
    strDay.value = "${days[day - 1]}, ${months[month - 1]} $dayInMonth";
  }

  applyWallpaper(int typeWallpaper) async {
    Get.back();

    String result = '';
    try {
      switch (typeWallpaper) {
        case 0:
          try {
            result = await AsyncWallpaper.setWallpaperFromFile(
              filePath: link.value,
              wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
            )
                ? 'Wallpaper set'
                : 'Failed to get wallpaper.';
          } on PlatformException {
            result = 'Failed to get wallpaper.';
          }

          break;

        case 1:
          try {
            result = await AsyncWallpaper.setWallpaperFromFile(
              filePath: link.value,
              wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
            )
                ? 'Wallpaper set'
                : 'Failed to get wallpaper.';
          } on PlatformException {
            result = 'Failed to get wallpaper.';
          }

          break;

        case 2:
          try {
            result = await AsyncWallpaper.setWallpaperFromFile(
              filePath: link.value,
              wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
            )
                ? 'Wallpaper set'
                : 'Failed to get wallpaper.';
          } on PlatformException {
            result = 'Failed to get wallpaper.';
          }

          break;
      }

      result = 'Set wallpaper successfully';
    } on PlatformException {
      result = 'Failed to get wallpaper';
    }

    EasyLoading.showToast(result);
  }

  showToast(String text) {
    AppUtil.showToast(text);
  }

  changeValueReview () {
    review.value = !review.value;
  }

  onPressShare() {
    Share.share(
        'Install it and choose your favorite wallpapers: https://play.google.com/store/apps/details?id=com.vietapps.airlive');
  }

  onPressPremium() {
    Get.toNamed(AppRoute.subscriber_screen);
  }
}