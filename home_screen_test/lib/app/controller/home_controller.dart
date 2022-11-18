import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';
import 'package:home_screen_test/app/controller/category_controller.dart';
import 'package:video_player/video_player.dart';

enum RewardType { DOWNLOAD, APPLY }

class HomeController extends GetxController {
  Map data = {};
  AppController appController = Get.find<AppController>();

  CategoryController categoryController = Get.find<CategoryController>();

  RxInt currentIndexImage = 0.obs;

  List listCommon = [];

  RxBool showDownloading = false.obs;
  RxString type = ''.obs;
  RxString link = ''.obs;
  String video = '';
  Rx<Widget> containerBanner = Container().obs;

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

    data = appController.list[categoryController.currentIndexCategory.value];
  }

  void changeIndexImage(int value) {
    currentIndexImage.value = value;
  }
}
