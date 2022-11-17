import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'app_controller.dart';

class CategoryController extends GetxController {
  final AppController appController = Get.find<AppController>();

  List listCommon = [];

  @override
  void onInit() {
    super.onInit();

    print("appController.listDataHD.length: ${appController.listDataHD.length}");
    print("appController.listDataLive.length: ${appController.listDataLive.length}");

    for (int i = 0; i < appController.listDataHD.length; i++) {
      Map m = {};
      m['isShow'] = appController.listDataHD[i]['isShow'];
      m['title'] = appController.listDataHD[i]['title'];
      m['wallpapers'] = appController.listDataHD[i]['wallpapers'];
      m['type'] = 0;
      listCommon.add(m);
    }

    for (int i = 0; i < appController.listDataLive.length; i++) {
      Map m = {};
      m['isShow'] = appController.listDataLive[i]['isShow'];
      m['title'] = appController.listDataLive[i]['title'];
      m['wallpapers'] = appController.listDataLive[i]['wallpapers'];
      m['type'] = 1;
      listCommon.add(m);
    }

    print("listCommon.length: ${listCommon.length}");
  }
}
