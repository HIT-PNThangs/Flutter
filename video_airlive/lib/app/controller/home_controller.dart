import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../util/app_util.dart';
import 'app_controller.dart';

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
  void onReady() {
    // TODO: implement onReady
    super.onReady();

    _initVideo();
  }

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
  }

  changeIndexCategory(int value) {
    currentIndexCategory.value = value;

    listImage.clear();
    listImage.addAll(appController.list[currentIndexCategory.value]['wallpapers']);

    title.value = appController.list[currentIndexCategory.value]['title'];

    listImage.refresh();
    title.refresh();
  }

  _initVideo() async {
    try {
      showDownloading.value = true;
      Directory? directory = await getTemporaryDirectory();
      Directory directoryDownload = Directory('${directory.path}/AirLive/videosdl');
      bool check = await directoryDownload.exists();
      if (!check) {
        await directoryDownload.create(recursive: true);
      }
      final ByteData videoData = await NetworkAssetBundle(Uri.parse(video)).load("");
      final Uint8List bytes = videoData.buffer.asUint8List();
      final buffer = bytes.buffer;
      _videoPath = '${directoryDownload.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
      File fileVideo = File(_videoPath);
      await fileVideo.writeAsBytes(buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
      showDownloading.value = false;
      _videoPlayerController = VideoPlayerController.file(fileVideo);
      if (_videoPlayerController != null) {
        await _videoPlayerController!.initialize();
        _videoPlayerController!.setVolume(0);
        double videoWidth = _videoPlayerController!.value.size.width;
        double videoHeight = _videoPlayerController!.value.size.height;
        double videoWidthScale = videoWidth / (videoHeight / 2);
        double videoHeightScale = videoHeight / (videoWidth / 0.95);
        if (videoHeightScale < 2) {
          scaleVideo.value = 2 / videoHeightScale;
        } else if (videoWidthScale < 0.95) {
          scaleVideo.value = 0.95 / videoWidthScale;
        }
        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: true,
          showControls: true,
          showOptions: false,
          showControlsOnInitialize: false,
        );
        playerWidget = Chewie(
          controller: _chewieController!,
        );
        showPlayerWidget.value = true;
      }
    } on Exception catch (e) {
      showDownloading.value = false;
      AppUtil.showToast('Live wallpaper load failed, please try again later');
    }
  }
}
