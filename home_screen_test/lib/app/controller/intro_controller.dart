import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../route/app_pages.dart';

class IntroController extends GetxController {
  RxInt currentIndex = 0.obs;
  CarouselController carouselController = CarouselController();

  onPressButtonNext() async {
    if (currentIndex.value < 2) {
      carouselController.nextPage();
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setInt('showIntro', 0);
      Get.offAndToNamed(AppRoute.home_screen);
    }
  }
}
