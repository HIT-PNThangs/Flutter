import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

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
  PageController loopPageController = PageController(initialPage: 0);

  bool isAdRewardDone = false;
  RxBool showRewardSuccessView = false.obs;
  RxBool hideBanner = false.obs;
  Rx<RewardType> rewardType = RewardType.DOWNLOAD.obs;
  Chewie? playerWidget;
  RxBool showPlayerWidget = false.obs;
  RxDouble scaleVideo = 1.0.obs;

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

  onPressCameraPick() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera, maxWidth: 1000);
    Get.back();
    if (photo != null) {
      onPressImageByPath(photo.path);
    }
  }

  onPressAlbum() async {
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.gallery, maxWidth: 1000);
    Get.back();
    if (photo != null) {
      onPressImageByPath(photo.path);
    }
  }

  onPressImageByPath(String path) {
    appController.goToPreview(path);

    // if (appController.interstitialAd != null && !appController.isPremium.value) {
    //   appController.interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
    //     onAdShowedFullScreenContent: (InterstitialAd ad) => print('$ad onAdShowedFullScreenContent.'),
    //     onAdDismissedFullScreenContent: (InterstitialAd ad) {
    //       print('$ad onAdDismissedFullScreenContent.');
    //       ad.dispose();
    //       appController.goToPreview(path, '', '', 'PATH');
    //     },
    //     onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
    //       print('$ad onAdFailedToShowFullScreenContent: $error');
    //       ad.dispose();
    //       appController.goToPreview(path, '', '', 'PATH');
    //     },
    //     onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
    //   );
    //   appController.interstitialAd?.show();
    // } else {
    //   appController.goToPreview(path, '', '', 'PATH');
    // }
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

  // onPressApply(BuildContext context) async {
  //   // if (video.isNotEmpty && _videoPath.isNotEmpty) {
  //   //   _applyLiveWallpaper();
  //   // }
  //   // else {
  //   //   showModalBottomSheet<void>(
  //   //       context: context,
  //   //       shape: RoundedRectangleBorder(
  //   //         borderRadius: BorderRadius.vertical(
  //   //           top: Radius.circular(14.0.sp),
  //   //         ),
  //   //       ),
  //   //       isScrollControlled: true,
  //   //       builder: (btsContext) {
  //   //         return Container(
  //   //           padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
  //   //           child: Column(
  //   //             mainAxisSize: MainAxisSize.min,
  //   //             crossAxisAlignment: CrossAxisAlignment.start,
  //   //             children: [
  //   //               Row(
  //   //                 mainAxisAlignment: MainAxisAlignment.end,
  //   //                 children: [
  //   //                   Padding(
  //   //                     padding: EdgeInsets.only(top: 4.0.sp),
  //   //                     child: HeaderButton(
  //   //                       icon: AppImages.ic_close,
  //   //                       iconColor: AppColors.white,
  //   //                       backgroundColor: AppColors.black.withOpacity(0.3),
  //   //                       onPressed: Get.back,
  //   //                       iconHeight: 24.0.sp,
  //   //                       iconWidth: 24.0.sp,
  //   //                       mini: true,
  //   //                     ),
  //   //                   ),
  //   //                 ],
  //   //               ),
  //   //               TouchableWidget(
  //   //                 onPressed: () => _applyWallpaper(0),
  //   //                 child: Text(
  //   //                   'Apply to Home screen',
  //   //                   style: TextStyle(
  //   //                     color: AppColors.blackText,
  //   //                     fontSize: 16.0.sp,
  //   //                     fontFamily: AppFonts.robotoRegular,
  //   //                   ),
  //   //                 ),
  //   //               ),
  //   //               Divider(height: 1, color: AppColors.primary),
  //   //               TouchableWidget(
  //   //                 onPressed: () => _applyWallpaper(1),
  //   //                 child: Text(
  //   //                   'Apply to Lock screen',
  //   //                   style: TextStyle(
  //   //                     color: AppColors.blackText,
  //   //                     fontSize: 16.0.sp,
  //   //                     fontFamily: AppFonts.robotoRegular,
  //   //                   ),
  //   //                 ),
  //   //               ),
  //   //               Divider(height: 1, color: AppColors.primary),
  //   //               TouchableWidget(
  //   //                 onPressed: () => _applyWallpaper(2),
  //   //                 child: Text(
  //   //                   'Apply to Both screens',
  //   //                   style: TextStyle(
  //   //                     color: AppColors.blackText,
  //   //                     fontSize: 16.0.sp,
  //   //                     fontFamily: AppFonts.robotoRegular,
  //   //                   ),
  //   //                 ),
  //   //               ),
  //   //               Divider(height: 1, color: AppColors.primary),
  //   //               SizedBox(height: 24.0.sp),
  //   //             ],
  //   //           ),
  //   //         );
  //   //       });
  //   // }
  //
  //   showModalBottomSheet<void>(
  //       context: context,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(
  //           top: Radius.circular(14.0.sp),
  //         ),
  //       ),
  //       isScrollControlled: true,
  //       builder: (btsContext) {
  //         return Container(
  //           padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 children: [
  //                   Padding(
  //                     padding: EdgeInsets.only(top: 4.0.sp),
  //                     child: HeaderButton(
  //                       icon: AppImages.ic_close,
  //                       iconColor: AppColors.white,
  //                       backgroundColor: AppColors.black.withOpacity(0.3),
  //                       onPressed: Get.back,
  //                       iconHeight: 24.0.sp,
  //                       iconWidth: 24.0.sp,
  //                       mini: true,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               TouchableWidget(
  //                 onPressed: () => _applyWallpaper(0),
  //                 child: Text(
  //                   'Apply to Home screen',
  //                   style: TextStyle(
  //                     color: AppColors.blackText,
  //                     fontSize: 16.0.sp,
  //                     fontFamily: AppFonts.robotoRegular,
  //                   ),
  //                 ),
  //               ),
  //               const Divider(height: 1, color: AppColors.primary),
  //               TouchableWidget(
  //                 onPressed: () => _applyWallpaper(1),
  //                 child: Text(
  //                   'Apply to Lock screen',
  //                   style: TextStyle(
  //                     color: AppColors.blackText,
  //                     fontSize: 16.0.sp,
  //                     fontFamily: AppFonts.robotoRegular,
  //                   ),
  //                 ),
  //               ),
  //               const Divider(height: 1, color: AppColors.primary),
  //               TouchableWidget(
  //                 onPressed: () => _applyWallpaper(2),
  //                 child: Text(
  //                   'Apply to Both screens',
  //                   style: TextStyle(
  //                     color: AppColors.blackText,
  //                     fontSize: 16.0.sp,
  //                     fontFamily: AppFonts.robotoRegular,
  //                   ),
  //                 ),
  //               ),
  //               const Divider(height: 1, color: AppColors.primary),
  //               SizedBox(height: 24.0.sp),
  //             ],
  //           ),
  //         );
  //       });
  // }

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
