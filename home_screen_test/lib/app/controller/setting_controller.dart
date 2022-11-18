import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_util.dart';
import 'app_controller.dart';

class SettingController extends GetxController {
  final AppController _appController = Get.find<AppController>();

  // onPressPremium() {
  //   Get.toNamed(AppRoute.subscribe_screen);
  // }
  //
  // onPressTutorial() {
  //   Get.toNamed(AppRoute.help_screen);
  // }

  // onPressRating() async {
  //   final InAppReview inAppReview = InAppReview.instance;
  //
  //   if (await inAppReview.isAvailable()) {
  //     inAppReview.requestReview();
  //   } else {
  //     AppUtil.showToast(
  //         'Unable to submit a review at this time, please try again later');
  //   }
  // }

  // onPressShare() {
  //   Share.share(
  //       'Install it and choose your favorite wallpapers: https://play.google.com/store/apps/details?id=com.vietapps.airlive');
  // }

  onPressPrivacy() {
    _openLink(
        'https://sites.google.com/view/livewallpaper-hdbackground/privacy-policy');
  }

  onPressTerm() {
    _openLink(
        'https://sites.google.com/view/livewallpaper-hdbackground/terms-conditions');
  }

  onPressContact() {
    _openLink(
        'https://sites.google.com/view/livewallpaper-hdbackground/support');
  }

  onPressRestore() async {
    await FlutterInappPurchase.instance.initialize();
    List<PurchasedItem> pis =
        await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];
    if (pis.isNotEmpty) {
      bool check = false;

      for (int i = 0; i < pis.length; i++) {
        if (pis[i].purchaseStateAndroid == PurchaseState.purchased) {
          check = true;
          break;
        }
      }

      _appController.isPremium.value = check;
    } else {
      _appController.isPremium.value = false;
    }

    AppUtil.showToast('Restore successful');
    FlutterInappPurchase.instance.finalize();
  }

  _openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
