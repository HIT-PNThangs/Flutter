import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryController());
  }
}
