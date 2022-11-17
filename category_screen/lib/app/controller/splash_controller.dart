import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../app_page.dart';
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

    BaseResponse responseHD = await ApiClient.instance
        .request(endPoint: ApiConstant.ep_cates, method: ApiClient.POST, data: json.encode({"type": 0}));

    BaseResponse responseLive = await ApiClient.instance
        .request(endPoint: ApiConstant.ep_cates, method: ApiClient.POST, data: json.encode({"type": 1}));

    if (responseHD.result == true && responseLive.result == true) {
      AppController appController = Get.find<AppController>();

      appController.listDataHD = responseHD.data;
      appController.listDataLive = responseLive.data;

      Get.offAndToNamed(AppRoute.category_screen);
    } else {
      AppUtil.showToast((responseHD.message ?? '').isNotEmpty
          ? (responseHD.message ?? '')
          : (responseLive.message ?? '').isNotEmpty
          ? (responseLive.message ?? '')
          : 'Unknown error');
    }
  }
}
