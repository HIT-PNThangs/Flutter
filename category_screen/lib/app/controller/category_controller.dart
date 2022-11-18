import 'package:get/get.dart';

import 'app_controller.dart';

class CategoryController extends GetxController {
  final AppController appController = Get.find<AppController>();

  List listCommon = [];

  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    print("appController.listData.length: ${appController.listData.length}");

    for (int i = 0; i < appController.listData.length; i++) {
      listCommon.add(appController.listData[i]);
    }

    print("listCommon.length: ${listCommon.length}");
  }
}
