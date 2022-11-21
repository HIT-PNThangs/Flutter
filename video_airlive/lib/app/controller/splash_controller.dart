import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../data/model/base_response.dart';
import '../data/provider/api_client.dart';
import '../data/provider/api_constant.dart';
import '../util/app_util.dart';
import 'app_controller.dart';

class SplashController extends GetxController {
  BuildContext? buildContext;

  @override
  void onReady() async {
    super.onReady();

    BaseResponse response = await ApiClient.instance
        .request(endPoint: ApiConstant.ep_cates, method: ApiClient.POST, data: json.encode({"type": ""}));

    if (response.result == true) {
      AppController appController = Get.find<AppController>();

      appController.list = response.data;

      // Get.offAndToNamed(AppRoute.category_screen);
    } else {
      AppUtil.showToast((response.message ?? '').isNotEmpty ? (response.message ?? '') : 'Unknown error');
    }
  }
}
