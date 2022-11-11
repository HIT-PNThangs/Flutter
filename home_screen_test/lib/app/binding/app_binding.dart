import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
  }
}
