import 'package:get/get.dart';

import '../controller/subscribe_controller.dart';

class SubscribeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscribeController());
  }
}
