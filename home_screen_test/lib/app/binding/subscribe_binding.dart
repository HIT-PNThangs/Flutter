import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/subscribe_controller.dart';

class SubscribeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscribeController());
  }
}
