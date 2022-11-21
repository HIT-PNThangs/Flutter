import 'package:get/get.dart';

class SelectedImageController extends GetxController {
  RxString link = ''.obs;

  @override
  void onInit() {
    super.onInit();

    link.value = Get.arguments['link'];
  }
}