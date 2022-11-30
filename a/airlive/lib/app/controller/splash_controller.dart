import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';
import 'package:get/get.dart';

import '../../util/app_util.dart';
import '../data/model/base_response.dart';
import '../data/provider/api_client.dart';
import '../data/provider/api_constant.dart';
import '../route/app_pages.dart';
import 'app_controller.dart';

class SplashController extends GetxController {
  BuildContext? buildContext;
  AppController appController = Get.find<AppController>();

  @override
  void onReady() async {
    super.onReady();

    await _checkPurchased();



    await appController.getIAPProductDetails();

    BaseResponse response = await ApiClient.instance
        .request(endPoint: ApiConstant.ep_cates, method: ApiClient.POST, data: json.encode({"type": ""}));

    if (response.result == true) {
      appController.list = response.data;

      Get.offAndToNamed(AppRoute.home_screen);
    } else {
      AppUtil.showToast((response.message ?? '').isNotEmpty ? (response.message ?? '') : 'Unknown error');
    }
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
}
