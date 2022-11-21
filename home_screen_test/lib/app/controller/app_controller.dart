import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../ui/theme/app_colors.dart';
import '../ui/widget/common_screen.dart';

class AppController extends GetxController {
  List list = [];

  RxBool isPremium = false.obs;

  // InterstitialAd? interstitialAd;
  // RewardedAd? rewardedAd;
  RxList<FileSystemEntity> listFileDownloaded = RxList();

  @override
  void onReady() {
    StyleOfStatusBarContent styleOfStatusBarContent = StyleOfStatusBarContent(StatusBarStyle.light);
    SystemChrome.setSystemUIOverlayStyle((styleOfStatusBarContent.androidStyle ?? SystemUiOverlayStyle.light)
        .copyWith(statusBarColor: AppColors.transparent, statusBarBrightness: styleOfStatusBarContent.iosStyle));

    // initAdInterstitial();
    // initAdReward();

    updateDownloadedImages();
    super.onReady();
  }

  // initAdInterstitial() {
  //   InterstitialAd.load(
  //     adUnitId: AppConstant.IDInterstitialAd,
  //     request: AdRequest(),
  //     adLoadCallback: InterstitialAdLoadCallback(
  //       onAdLoaded: (InterstitialAd ad) {
  //         interstitialAd = ad;
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('InterstitialAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  // initAdReward() {
  //   RewardedAd.load(
  //     adUnitId: AppConstant.IDRewardAppAd,
  //     request: AdRequest(),
  //     rewardedAdLoadCallback: RewardedAdLoadCallback(
  //       onAdLoaded: (RewardedAd ad) {
  //         rewardedAd = ad;
  //       },
  //       onAdFailedToLoad: (LoadAdError error) {
  //         print('RewardedAd failed to load: $error');
  //       },
  //     ),
  //   );
  // }

  // onPressItem(Map item) {
  //   if (interstitialAd != null && !isPremium.value) {
  //     interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
  //       onAdShowedFullScreenContent: (InterstitialAd ad) => print('$ad onAdShowedFullScreenContent.'),
  //       onAdDismissedFullScreenContent: (InterstitialAd ad) {
  //         print('$ad onAdDismissedFullScreenContent.');
  //         ad.dispose();
  //         goToPreview(item['image'], item['tag'], item['video'], 'URL');
  //       },
  //       onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
  //         print('$ad onAdFailedToShowFullScreenContent: $error');
  //         ad.dispose();
  //         goToPreview(item['image'], item['tag'], item['video'], 'URL');
  //       },
  //       onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
  //     );
  //     interstitialAd?.show();
  //   } else {
  //     goToPreview(item['image'], item['tag'], item['video'], 'URL');
  //   }
  // }

  // goToPreview(String link, String tag, String video, String type) {
  //   interstitialAd = null;
  //   initAdInterstitial();
  //   Get.toNamed(AppRoute.preview_screen, arguments: {
  //     'type': type,
  //     'link': link,
  //     'tag': tag,
  //     'video': video,
  //   });
  // }

  updateDownloadedImages() async {
    Directory? directory = await getApplicationDocumentsDirectory();
    Directory directoryDownload = Directory('${directory.path}/AirLive/imagesdl');
    bool check = await directoryDownload.exists();

    if (!check) {
      await directoryDownload.create(recursive: true);
    }

    listFileDownloaded.value = directoryDownload.listSync();
  }
}