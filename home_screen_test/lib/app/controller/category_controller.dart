import 'package:get/get.dart';

import 'app_controller.dart';



class CategoryController extends GetxController {
  AppController appController = AppController();

  List listCommon = [];
  RxInt currentIndexCategory = 0.obs;

  @override
  void onInit() {
    super.onInit();

    for(int i = 0; i < appController.list.length; i++) {
      listCommon.add(appController.list[i]);
    }
  }

  void changeIndexCategory(int value) {
    currentIndexCategory.value = value;
  }
}
