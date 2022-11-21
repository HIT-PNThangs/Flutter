import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';
import 'package:loop_page_view/loop_page_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

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

  onPressShare() {
    Share.share(
        'Install it and choose your favorite wallpapers: https://play.google.com/store/apps/details?id=com.vietapps.airlive');
  }
}
