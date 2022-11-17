import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';

class CategoryController extends GetxController {
  List listCommon = [];

  AppController appController = AppController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    for(int i = 0; i < appController.list.length; i++) {
      listCommon.add(appController.list[i]);
    }
  }


}