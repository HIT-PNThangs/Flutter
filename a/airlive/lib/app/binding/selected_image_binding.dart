import 'package:get/get.dart';

import '../controller/selected_image_controller.dart';

class SelectedImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectedImageController());
  }
}
