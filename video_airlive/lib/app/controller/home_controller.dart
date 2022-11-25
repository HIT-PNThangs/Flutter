import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../../util/app_util.dart';
import 'app_controller.dart';

enum RewardType { DOWNLOAD, APPLY }

class HomeController extends GetxController {
  AppController appController = Get.find<AppController>();

  RxInt currentIndexImage = 0.obs;
  RxInt currentIndexCategory = 0.obs;

  List listCommon = [];
  RxList<dynamic> listWallpapers = RxList();

  RxString title = "".obs;

  RxString strTime = "".obs;
  RxString strDay = "".obs;

  RxBool review = true.obs;

  RxBool showDownloading = false.obs;
  RxString type = ''.obs;
  RxString link = ''.obs;
  String video = '';
  Rx<Widget> containerBanner = Container().obs;

  FixedExtentScrollController scrollController = FixedExtentScrollController();
  LoopPageController loopPageController = LoopPageController(initialPage: 0);

  bool isAdRewardDone = false;
  RxBool showRewardSuccessView = false.obs;
  RxBool hideBanner = false.obs;
  Rx<RewardType> rewardType = RewardType.DOWNLOAD.obs;

  @override
  void onInit() {
    super.onInit();

    listWallpapers.clear();
    listWallpapers.addAll(appController.list[currentIndexCategory.value]['wallpapers']);

    title.value = appController.list[currentIndexCategory.value]['title'];

    listCommon.addAll(appController.list);

    getTime();
  }

  changeIndexImage(int value) {
    currentIndexImage.value = value;
    loopPageController.jumpToPage(value);
  }

  changeImage(int value) {
    currentIndexImage.value = value;
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

  changeIndexCategory(int value) {
    currentIndexCategory.value = value;

    listWallpapers.clear();
    listWallpapers.addAll(appController.list[currentIndexCategory.value]['wallpapers']);

    title.value = appController.list[currentIndexCategory.value]['title'];

    listWallpapers.refresh();
    title.refresh();
  }

  changeValueReview() {
    review.value = !review.value;
  }

  showToast(String text) {
    AppUtil.showToast(text);
  }
}
