import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_util.dart';
import '../route/app_pages.dart';
import 'app_controller.dart';

enum RewardType { DOWNLOAD, APPLY }

class HomeController extends GetxController {
  AppController appController = Get.find<AppController>();

  RxInt currentIndexImage = 0.obs;
  RxInt currentIndexCategory = 0.obs;

  List listCommon = [];
  RxList<dynamic> listWallpapers = RxList();
  RxList<dynamic> listVideo = RxList();

  RxString title = "".obs;

  RxString strTime = "".obs;
  RxString strDay = "".obs;

  RxBool review = false.obs;

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

    for(var item in listWallpapers) {
      if(item['video'] != "") {
        listVideo.add(item['video']);
      }
    }

    title.value = appController.list[currentIndexCategory.value]['title'];

    listCommon.addAll(appController.list);

    getTime();
  }

  changeIndexImage(int value) {
    currentIndexImage.value = value;
    loopPageController.jumpToPage(value);
    // scrollController.jumpToItem(value);
  }

  changeImage(int value) {
    currentIndexImage.value = value;
    // scrollController.jumpToItem(value);
    // loopPageController.jumpToPage(value);
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

  onPressShare() {
    Share.share(
        'Install it and choose your favorite wallpapers: https://play.google.com/store/apps/details?id=com.vietapps.airlive');
  }

  onPressPrivacy() {
    _openLink('https://sites.google.com/view/livewallpaper-hdbackground/privacy-policy');
  }

  onPressTerm() {
    _openLink('https://sites.google.com/view/livewallpaper-hdbackground/terms-conditions');
  }

  onPressContact() {
    _openLink('https://sites.google.com/view/livewallpaper-hdbackground/support');
  }

  _openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  applyWallpaper(int typeWallpaper) async {
    Get.back();

    // Directory? directoryTemp = await getTemporaryDirectory();
    // String? path = '${directoryTemp.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    //
    // if (type.value == 'URL') {
    //   try {
    //     showDownloading.value = true;
    //     final ByteData imageData = await NetworkAssetBundle(Uri.parse(link.value)).load("");
    //     final Uint8List bytes = imageData.buffer.asUint8List();
    //     final buffer = bytes.buffer;
    //     await File(path).writeAsBytes(buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    //     showDownloading.value = false;
    //   } on Exception catch (e) {
    //     showDownloading.value = false;
    //     print(e);
    //     showToast('Something wrong, please try again later');
    //   }
    // } else if (type.value == 'PATH') {
    //   path = link.value;
    // }

    String result = '';
    try {
      showDownloading.value = true;

      String url = listWallpapers[currentIndexImage.value]['image'];

      switch (typeWallpaper) {
        case 0:
          try {

            result = await AsyncWallpaper.setWallpaper(
              url: url,
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
            result = await AsyncWallpaper.setWallpaper(
              url: url,
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
            result = await AsyncWallpaper.setWallpaper(
              url: url,
              wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
            )
                ? 'Wallpaper set'
                : 'Failed to get wallpaper.';
          } on PlatformException {
            result = 'Failed to get wallpaper.';
          }

          break;
      }

      showDownloading.value = false;
      result = 'Set live wallpaper successfully';
    } on PlatformException {
      showDownloading.value = false;
      result = 'Failed to get wallpaper';
    }
    showToast(result);
  }

  showToast(String text) {
    AppUtil.showToast(text);
  }
}
