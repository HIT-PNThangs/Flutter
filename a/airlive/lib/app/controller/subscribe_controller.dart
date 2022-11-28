import 'dart:async';

import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../util/app_util.dart';
import 'app_controller.dart';

class SubscribeController extends GetxController {
  RxList<IAPItem> rxListIAPItem = RxList<IAPItem>();
  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;

  final AppController _appController = Get.find<AppController>();

  RxBool showClose = false.obs;

  @override
  void onInit() {
    asyncInitState();
    showCloseButton();
    super.onInit();
  }

  void asyncInitState() async {
    await FlutterInappPurchase.instance.initialize();

    // lỗi gì đó nếu để 1 wf_yearly thì chỉ lấy lấy về wf_yearly chứ ko lấy được wf_weekly wf_monthly
    List<IAPItem> list =
        await FlutterInappPurchase.instance.getSubscriptions(['wf_weekly', 'wf_yearly', 'wf_monthly', 'wf_yearly']);

    list.sort((a, b) => (double.tryParse(a.price ?? '0.0') ?? 0.0).compareTo((double.tryParse(b.price ?? '0.0') ?? 0.0)));

    if (list.length > 3) {
      rxListIAPItem.value = [list[0], list[1], list[2]];
    } else {
      rxListIAPItem.value = list;
    }

    _purchaseUpdatedSubscription = FlutterInappPurchase.purchaseUpdated.listen((productItem) {
      String name = (productItem?.productId ?? '');

      switch (productItem?.productId) {
        case 'wf_weekly':
          name = 'Weekly';
          break;

        case 'wf_monthly':
          name = 'Monthly';
          break;

        case 'wf_yearly':
          name = 'Yearly';
          break;
      }

      AppUtil.showToast('Congratulations! you have successfully purchased the $name premium package');
      _appController.isPremium.value = true;
    });

    _purchaseErrorSubscription = FlutterInappPurchase.purchaseError.listen((purchaseError) {
      AppUtil.showToast('An error occurred, please try again later');
    });
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
