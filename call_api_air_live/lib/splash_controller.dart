import 'dart:convert';

import 'package:call_api_air_live/app/data/model/base_response.dart';
import 'package:call_api_air_live/app/data/provider/api_client.dart';
import 'package:call_api_air_live/app/data/provider/api_constant.dart';
import 'package:call_api_air_live/app/data/util/app_util.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/app_controller.dart';

class SplashController extends GetxController {
  BuildContext? buildContext;

  @override
  void onReady() async {
    super.onReady();

    BaseResponse responseHD = await ApiClient.instance.request(
        endPoint: ApiConstant.ep_cates,
        method: ApiClient.POST,
        data: json.encode({"type": 0}));

    BaseResponse responseLive = await ApiClient.instance.request(
        endPoint: ApiConstant.ep_cates,
        method: ApiClient.POST,
        data: json.encode({"type": 1}));

    if (responseHD.result == true && responseLive.result == true) {
      AppController appController = Get.find<AppController>();

      appController.listDataHD = responseHD.data;
      appController.listDataLive = responseLive.data;
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // int showIntro = prefs.getInt('showIntro') ?? 1;
      // await Future.delayed(Duration(seconds: 1));
      // if (showIntro == 1) {
      //   Get.offAndToNamed(AppRoute.intro_screen);
      // } else {
      //   Get.offAndToNamed(AppRoute.home_screen);
      // }
      // Get.offAndToNamed(AppRoute.start_screen);
    } else {
      AppUtil.showToast((responseHD.message ?? '').isNotEmpty
          ? (responseHD.message ?? '')
          : (responseLive.message ?? '').isNotEmpty
          ? (responseLive.message ?? '')
          : 'Unknown error');
    }
  }
}
