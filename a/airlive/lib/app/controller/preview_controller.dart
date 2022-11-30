import 'dart:io';

import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

import '../../util/app_constant.dart';
import '../../util/app_util.dart';
import '../ui/loading/custom_animation.dart';
import '../ui/loading/easy_loading.dart';
import 'app_controller.dart';

class PreviewController extends GetxController {
  AppController appController = Get.find<AppController>();

  RxString type = "".obs;
  RxString urlImage = "".obs;
  RxString urlVideo = "".obs;

  // VideoPlayerController? _videoPlayerController;
  // ChewieController? _chewieController;
  // Chewie? playerWidget;

  late BannerAd _bannerAd;
  Rx<Widget> containerBanner = Container().obs;

  RxBool showDownloading = false.obs;
  String _videoPath = '';
  RxDouble scaleVideo = 1.0.obs;
  RxBool showPlayerWidget = false.obs;

  @override
  void onInit() {
    type.value = Get.arguments['type'];
    urlImage.value = Get.arguments['image'].toString();
    urlVideo.value = Get.arguments['video'].toString();

    _checkPurchased();
    if (!appController.isPremium.value) {
      _initAdBanner();
    }

    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.circle
      ..loadingStyle = EasyLoadingStyle.dark
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..userInteractions = true
      ..dismissOnTap = false
      ..customAnimation = CustomAnimation();

    super.onInit();
  }

  _checkPurchased() async {
    await FlutterInappPurchase.instance.initialize();

    List<PurchasedItem> pis = await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];

    if (pis.isNotEmpty) {
      bool check = false;
      for (int i = 0; i < pis.length; i++) {
        if (pis[i].purchaseStateAndroid == PurchaseState.purchased) {
          check = true;
          break;
        }
      }
      appController.isPremium.value = check;
    } else {
      appController.isPremium.value = false;
    }

    FlutterInappPurchase.instance.finalize();
  }

  // @override
  // void onReady() async {
  //   if (urlVideo != "") {
  //     _initVideo();
  //   }
  //
  //   super.onReady();
  // }

  // _initVideo() async {
  //   try {
  //     showDownloading.value = true;
  //     Directory? directory = await getTemporaryDirectory();
  //     Directory directoryDownload = Directory('${directory.path}/AirLive/videosdl');
  //     bool check = await directoryDownload.exists();
  //     if (!check) {
  //       await directoryDownload.create(recursive: true);
  //     }
  //     final ByteData videoData = await NetworkAssetBundle(Uri.parse(urlVideo.value)).load("");
  //     final Uint8List bytes = videoData.buffer.asUint8List();
  //     final buffer = bytes.buffer;
  //     _videoPath = '${directoryDownload.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
  //     File fileVideo = File(_videoPath);
  //     await fileVideo.writeAsBytes(buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
  //     showDownloading.value = false;
  //     _videoPlayerController = VideoPlayerController.file(fileVideo);
  //     if (_videoPlayerController != null) {
  //       await _videoPlayerController!.initialize();
  //       _videoPlayerController!.setVolume(0);
  //       double videoWidth = _videoPlayerController!.value.size.width;
  //       double videoHeight = _videoPlayerController!.value.size.height;
  //       double videoWidthScale = videoWidth / (videoHeight / 2);
  //       double videoHeightScale = videoHeight / (videoWidth / 0.95);
  //       if (videoHeightScale < 2) {
  //         scaleVideo.value = 2 / videoHeightScale;
  //       } else if (videoWidthScale < 0.95) {
  //         scaleVideo.value = 0.95 / videoWidthScale;
  //       }
  //       _chewieController = ChewieController(
  //         videoPlayerController: _videoPlayerController!,
  //         autoPlay: true,
  //         looping: true,
  //         showControls: true,
  //         showOptions: false,
  //         showControlsOnInitialize: false,
  //       );
  //       playerWidget = Chewie(
  //         controller: _chewieController!,
  //       );
  //       showPlayerWidget.value = true;
  //     }
  //   } on Exception catch (e) {
  //     showDownloading.value = false;
  //     showToast('Live wallpaper load failed, please try again later');
  //   }
  // }

  downloadImage() async {
    await EasyLoading.show(status: "Loading...");

    try {
      await GallerySaver.saveImage(urlImage.value, albumName: 'AirLive');

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Wallpaper download successful!', duration: const Duration(seconds: 1));
    } on Exception catch (e) {
      print(e);

      EasyLoading.dismiss();
      EasyLoading.showError('Wallpaper download failed, please try again later', duration: const Duration(seconds: 1));
    }

    EasyLoading.dismiss();
  }

  downloadVideo() async {
    await EasyLoading.show(status: "Loading...");

    try {
      await GallerySaver.saveVideo(_videoPath, albumName: 'AirLive');

      EasyLoading.dismiss();
      EasyLoading.showSuccess('Live Wallpaper download successful!', duration: const Duration(seconds: 1));
    } on Exception catch (e) {
      print(e);

      EasyLoading.dismiss();
      EasyLoading.showError('Live Wallpaper download failed, please try again later', duration: const Duration(seconds: 1));
    }

    EasyLoading.dismiss();
  }

  applyWallpaper(int typeWallpaper) async {
    try {
      switch (typeWallpaper) {
        case 0:
          Get.back();

          await EasyLoading.show(status: "Loading...");

          try {
            await AsyncWallpaper.setWallpaper(
              url: urlImage.value,
              wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
            )
                ? () {
                    // EasyLoading.dismiss();
                    EasyLoading.showSuccess('Wallpaper set', duration: const Duration(seconds: 1));
                  }
                : () {
                    // EasyLoading.dismiss();
                    EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
                  };
          } on PlatformException {
            EasyLoading.dismiss();
            EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
          }

          EasyLoading.dismiss();
          break;

        case 1:
          Get.back();

          await EasyLoading.show(status: "Loading...");

          try {
            await AsyncWallpaper.setWallpaper(
              url: urlImage.value,
              wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
            )
                ? () {
                    // EasyLoading.dismiss();
                    EasyLoading.showSuccess('Wallpaper set', duration: const Duration(seconds: 1));
                  }
                : () {
                    // EasyLoading.dismiss();
                    EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
                  };
          } on PlatformException {
            EasyLoading.dismiss();
            EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
          }

          EasyLoading.dismiss();
          break;

        case 2:
          Get.back();

          await EasyLoading.show(status: "Loading...");

          try {
            await AsyncWallpaper.setWallpaper(
              url: urlImage.value,
              wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
            )
                ? () {
                    // EasyLoading.dismiss();
                    EasyLoading.showSuccess('Wallpaper set', duration: const Duration(seconds: 1));
                  }
                : () {
                    // EasyLoading.dismiss();
                    EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
                  };
          } on PlatformException {
            EasyLoading.dismiss();
            EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
          }

          EasyLoading.dismiss();
          break;
      }
    } on PlatformException {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to get wallpaper', duration: const Duration(seconds: 1));
    }

    EasyLoading.dismiss();
  }

  Future<void> setLiveWallpaper() async {
    EasyLoading.show(status: "Loading...");

    var file = await DefaultCacheManager().getSingleFile(urlVideo.value);
    try {
      await AsyncWallpaper.setLiveWallpaper(
        filePath: file.path,
      )
          ? () {
              EasyLoading.dismiss();
              EasyLoading.showSuccess('Wallpaper set');
            }
          : () {
              EasyLoading.dismiss();
              EasyLoading.showError('Failed to get wallpaper');
            };
    } on PlatformException {
      EasyLoading.dismiss();
      EasyLoading.showError('Failed to get wallpaper');
    }

    EasyLoading.dismiss();
  }

  showToast(String text) {
    AppUtil.showToast(text);
  }

  _initAdBanner() {
    _bannerAd = BannerAd(
      adUnitId: AppConstant.IDBannerAd,
      size: AdSize(height: 70, width: Get.width.floor()),
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) => print('Ad loaded.'),
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          print('Ad Banner failed to load: $error');
        },
        onAdOpened: (Ad ad) => print('Ad opened.'),
        onAdClosed: (Ad ad) => print('Ad closed.'),
        onAdImpression: (Ad ad) => print('Ad impression.'),
      ),
    );

    _bannerAd.load();
    final AdWidget adWidget = AdWidget(ad: _bannerAd);
    containerBanner.value = Container(
      alignment: Alignment.center,
      width: _bannerAd.size.width.toDouble(),
      height: _bannerAd.size.height.toDouble(),
      child: adWidget,
    );
  }
}
