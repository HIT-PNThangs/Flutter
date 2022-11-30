import 'dart:io';

import 'package:airlive/app/res/image/app_images.dart';
import 'package:airlive/util/app_constant.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../util/extensions.dart';
import '../../util/app_util.dart';
import '../route/app_pages.dart';
import 'app_controller.dart';

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

  NativeAd? ad;

  PageController pageController = PageController(initialPage: 0);

  @override
  void onInit() {
    super.onInit();

    listWallpapers.clear();
    listWallpapers.addAll(appController.list[currentIndexCategory.value]['wallpapers']);

    title.value = appController.list[currentIndexCategory.value]['title'];

    listCommon.addAll(appController.list);

    getTime();

    NativeAd(
      adUnitId: AppConstant.IDNativeAd,
      factoryId: 'listTile',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (ad1) => ad = ad1 as NativeAd,
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          debugPrint('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    ).load();
  }

  @override
  void dispose() {
    super.dispose();

    ad?.dispose();
  }

  changeIndexImage(int value) {
    currentIndexImage.value = value;
    pageController.jumpToPage(value);
    // scrollController.jumpToItem(value);
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

  onPressPremium() {
    Get.toNamed(AppRoute.subscriber_screen);
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

  Future<bool> onWillPop(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  height: 200.0.sp,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 40),
                          child:
                              DefaultTextStyle(style: TextStyle(color: Colors.black, fontSize: 24), child: Text("Exit App")),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: DefaultTextStyle(
                              style: TextStyle(color: Colors.black, fontSize: 18),
                              child: Text("Are you sure you want to exit the app?", textAlign: TextAlign.center)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0.sp),
                          child: GestureDetector(
                            onTap: () {
                              exit(0);
                            },
                            child: Image.asset(
                              AppImages.image_exit,
                              width: 180,
                              height: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10.0.sp),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Image.asset(
                              AppImages.image_cancel,
                              width: 180,
                              height: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )) ??
        false;
  }

  showToast(String text) {
    AppUtil.showToast(text);
  }
}
