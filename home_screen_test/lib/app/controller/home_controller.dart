import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';

class HomeController extends GetxController {
  Map data = {};
  AppController appController = Get.find<AppController>();

  @override
  void onInit() {
    super.onInit();

    data = appController.listDataHD[3];
  }
}