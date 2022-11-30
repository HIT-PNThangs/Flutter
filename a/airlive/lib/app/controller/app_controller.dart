import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

import '../../util/app_constant.dart';
import '../ads/add_interstitial_ad_manager.dart';
import '../ads/add_open_ad_manager.dart';
import '../route/app_pages.dart';
import '../ui/theme/app_colors.dart';
import '../ui/widget/common_screen.dart';

class AppController extends GetxController {
  List list = [];

  List<ProductDetails> _listProductDetails = [];
  RxList<ProductDetails> listProductDetailsSub = RxList();

  Rx<ProductDetails> productDetailsFullPack =
      ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0).obs;

  StreamSubscription<dynamic>? _subscriptionIAP;

  RxBool isPremium = false.obs;

  InterstitialAd? interstitialAd;

  RxList<FileSystemEntity> listFileDownloaded = RxList();

  late AppOpenAdManager _appOpenAdManager;

  bool avoidShowOpenApp = false;

  @override
  void onReady() {
    StyleOfStatusBarContent styleOfStatusBarContent = StyleOfStatusBarContent(StatusBarStyle.light);
    SystemChrome.setSystemUIOverlayStyle((styleOfStatusBarContent.androidStyle ?? SystemUiOverlayStyle.light)
        .copyWith(statusBarColor: AppColors.transparent, statusBarBrightness: styleOfStatusBarContent.iosStyle));

    // initAdInterstitial();

    _appOpenAdManager = AppOpenAdManager()..loadAd();
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream.forEach((state) {
      if (state == AppState.foreground) {
        if (!isPremium.value && !avoidShowOpenApp) {
          _appOpenAdManager.showAdIfAvailable();
        }
      }
    });

    AddInterstitialAdManager().initializeInterstitialAds();

    _onInitIAPListener();

    super.onReady();
  }

  onPressPremiumByProduct(String productId) async {
    ProductDetails? productDetails = _listProductDetails.firstWhereOrNull((element) => element.id == productId);

    productDetails ??= listProductDetailsSub.value.firstWhereOrNull((element) => element.id == productId);

    if (productDetails == null || productDetails.id.isEmpty) {
      Get.snackbar('Error', '', colorText: AppColors.white);
    } else {
      final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
      InAppPurchase.instance.buyNonConsumable(purchaseParam: purchaseParam);
    }
  }

  _onInitIAPListener() {
    final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
    _subscriptionIAP = purchaseUpdated.listen((purchaseDetailsList) {
      _listenToPurchaseUpdated(purchaseDetailsList);
    }, onDone: () {
      _subscriptionIAP?.cancel();
    }, onError: (error) {});
  }

  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    purchaseDetailsList.forEach((PurchaseDetails purchaseDetails) async {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        // isPremium.value = false;
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          // isPremium.value = false;
        } else if (purchaseDetails.status == PurchaseStatus.purchased || purchaseDetails.status == PurchaseStatus.restored) {
          // isPremium.value = true;
          // final prefs = await SharedPreferences.getInstance();
          // prefs.setBool('isBought', true);
          if (purchaseDetails.productID == "com.vietapps.airlive.removeads") {
            isPremium.value = true;
          }
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await InAppPurchase.instance.completePurchase(purchaseDetails);
        }
      }
    });
  }

  _restorePurchases() async {
    // lấy danh sách các product đã mua, ios ghep sau
    if (Platform.isAndroid) {
      await InAppPurchase.instance.restorePurchases();
    } else {
      // final prefs = await SharedPreferences.getInstance();
      // bool isBought = prefs.getBool('isBought') ?? false;
      // if (isBought) {
      //   await InAppPurchase.instance.restorePurchases();
      // }
    }
  }

  getIAPProductDetails() async {
    final bool available = await InAppPurchase.instance.isAvailable();

    if (!available) {
      Get.snackbar('Error', 'Can not connect store', colorText: AppColors.white);
    } else {
      const Set<String> kIds = <String>{
        'com.vietapps.airlive.removeads',
      };

      final ProductDetailsResponse response = await InAppPurchase.instance.queryProductDetails(kIds);

      _listProductDetails = response.productDetails;

      productDetailsFullPack.value =
          _listProductDetails.firstWhereOrNull((element) => element.id == 'com.vietapps.airlive.removeads') ??
              ProductDetails(title: '', id: '', currencyCode: '', description: '', price: '', rawPrice: 0.0);
    }

    await _restorePurchases();
  }

  initAdInterstitial() {
    InterstitialAd.load(
      adUnitId: AppConstant.IDInterstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  onPressSetOrPlayVideo(Map map) {
    if (interstitialAd != null && !isPremium.value) {
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdShowedFullScreenContent.');
          Get.find<AppController>().avoidShowOpenApp = false;
        },
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          Get.find<AppController>().avoidShowOpenApp = true;
          Get.toNamed(AppRoute.preview_screen, arguments: map);
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          Get.find<AppController>().avoidShowOpenApp = true;
          Get.toNamed(AppRoute.preview_screen, arguments: map);
        },
        onAdImpression: (InterstitialAd ad) {
          print('$ad impression occurred.');
          Get.find<AppController>().avoidShowOpenApp = true;
        },
      );

      // Get.find<AppController>().avoidShowOpenApp = false;
      interstitialAd?.show();
    } else {
      Get.toNamed(AppRoute.preview_screen, arguments: map);
    }

    initAdInterstitial();
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
    if (interstitialAd != null && !isPremium.value) {
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) => print('$ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          goToPreview(path);
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          goToPreview(path);
        },
        onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
      );

      interstitialAd?.show();
    } else {
      goToPreview(path);
    }
  }

  goToPreview(String link) {
    interstitialAd = null;
    initAdInterstitial();
    Get.toNamed(AppRoute.selected_image_screen, arguments: {
      'link': link,
    });
  }

  selectedCategory() {
    if (interstitialAd != null && !isPremium.value) {
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) => print('$ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          Get.back();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          Get.back();
        },
        onAdImpression: (InterstitialAd ad) => print('$ad impression occurred.'),
      );

      interstitialAd?.show();
    } else {
      Get.back();
    }
  }
}
