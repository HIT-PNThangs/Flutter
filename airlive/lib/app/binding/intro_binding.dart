import 'package:get/get.dart';

import '../controller/intro_controller.dart';

class IntroBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IntroController());
  }
}
