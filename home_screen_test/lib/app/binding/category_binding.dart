import 'package:get/get.dart';

import '../controller/category_controller.dart';

class CategoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
  }
}
