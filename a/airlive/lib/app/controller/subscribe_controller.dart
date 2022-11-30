import 'dart:async';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_util.dart';
import '../ui/theme/app_colors.dart';
import 'app_controller.dart';

class SubscribeController extends GetxController {
  RxList<IAPItem> rxListIAPItem = RxList<IAPItem>();
  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;

  final AppController _appController = Get.find<AppController>();

  RxBool showClose = false.obs;

  @override
  void onInit() {
    showCloseButton();
    super.onInit();
  }

  @override
  void onClose() async {
    super.onClose();
    _purchaseUpdatedSubscription?.cancel();
    _purchaseUpdatedSubscription = null;

    _purchaseErrorSubscription?.cancel();
    _purchaseErrorSubscription = null;

    await FlutterInappPurchase.instance.finalize();
  }

  onPressPrivacy() {
    _openLink('https://sites.google.com/view/livewallpaper-hdbackground/privacy-policy');
  }

  onPressTerm() {
    _openLink('https://sites.google.com/view/livewallpaper-hdbackground/terms-conditions');
  }

  onPressRestore() async {
    List<PurchasedItem> pis = await FlutterInappPurchase.instance.getAvailablePurchases() ?? [];
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
  }

  onPressPurchase(IAPItem item) {
    FlutterInappPurchase.instance.requestSubscription(item.productId ?? '');
  }

  _openLink(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  showCloseButton() async {
    Future.delayed(const Duration(seconds: 5), () {
      showClose.value = !showClose.value;
    });
  }

  changeValueShowClose() {
    showClose.value = !showClose.value;
  }
}
