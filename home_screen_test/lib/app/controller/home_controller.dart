import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../route/app_pages.dart';

enum RewardType { DOWNLOAD, APPLY }

class HomeController extends GetxController {
  AppController appController = Get.find<AppController>();

  RxInt currentIndexImage = 0.obs;
  RxInt currentIndexCategory = 0.obs;

  List listCommon = [];
  RxList<dynamic> listImage = RxList();

  RxString title = "".obs;

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
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  Chewie? playerWidget;
  RxBool showPlayerWidget = false.obs;
  String _videoPath = '';
  RxDouble scaleVideo = 1.0.obs;

  @override
  void onInit() {
    super.onInit();

    listImage.clear();
    listImage.addAll(appController.list[currentIndexCategory.value]['wallpapers']);

    title.value = appController.list[currentIndexCategory.value]['title'];

    listCommon.addAll(appController.list);
  }

  changeIndexImage(int value) {
    currentIndexImage.value = value;
    loopPageController.jumpToPage(value);
    scrollController.jumpToItem(value);
  }

  changeImage(int value) {
    currentIndexImage.value = value;
    scrollController.jumpToItem(value);
    loopPageController.jumpToPage(value);
  }

  changeIndexCategory(int value) {
    currentIndexCategory.value = value;

    listImage.clear();
    listImage.addAll(appController.list[currentIndexCategory.value]['wallpapers']);

    title.value = appController.list[currentIndexCategory.value]['title'];

    listImage.refresh();
    title.refresh();
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

  onPressTutorial() {
    Get.toNamed(AppRoute.help_screen);
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
}
