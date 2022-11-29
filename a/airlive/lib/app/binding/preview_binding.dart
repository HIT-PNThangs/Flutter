import 'package:airlive/app/controller/preview_controller.dart';
import 'package:get/get.dart';

class PreviewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreviewController());
  }
}
