import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../util/app_util.dart';

class PreviewController extends GetxController {
  RxString type = "".obs;
  RxString urlImage = "".obs;
  RxString urlVideo = "".obs;

  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  Chewie? playerWidget;

  RxBool showDownloading = false.obs;
  String _videoPath = '';
  RxDouble scaleVideo = 1.0.obs;
  RxBool showPlayerWidget = false.obs;

  @override
  void onInit() {
    type.value = Get.arguments['type'];
    urlImage.value = Get.arguments['image'].toString();
    urlVideo.value = Get.arguments['video'].toString();

    // _checkPurchased();
    // if (!_appController.isPremium.value) {
    //   _initAdBanner();
    // }
    super.onInit();
  }

  @override
  void onReady() async {
    if (urlVideo != "") {
      _initVideo();
    }
    super.onReady();
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
      final ByteData videoData = await NetworkAssetBundle(Uri.parse(urlVideo.value)).load("");
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
      showToast('Live wallpaper load failed, please try again later');
    }
  }

  applyWallpaper(int typeWallpaper) async {
    String result = '';
    try {
      showDownloading.value = true;

      switch (typeWallpaper) {
        case 0:
          try {

            result = await AsyncWallpaper.setWallpaper(
              url: urlImage.value,
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
              url: urlImage.value,
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
              url: urlImage.value,
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