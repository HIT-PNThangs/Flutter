import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/selected_image_controller.dart';

class SelectedImageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SelectedImageController());
  }
}
