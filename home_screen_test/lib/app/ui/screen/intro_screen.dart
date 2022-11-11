import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../controller/intro_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_box_shadow.dart';
import '../widget/common_screen.dart';
import '../widget/touchable_widget.dart';

class IntroScreen extends GetView<IntroController> {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> listImageAsset = [
      AppImages.bg_intro1,
      AppImages.bg_intro2,
      AppImages.bg_intro3,
    ];

    return CommonScreen(
      child: Stack(
        children: [
          NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification overscroll) {
              overscroll.disallowIndicator();
              return true;
            },
            child: CarouselSlider(
              items: listImageAsset.map((e) {
                return Image.asset(
                  e,
                  fit: BoxFit.cover,
                  width: Get.width,
                  height: Get.height,
                );
              }).toList(),
              carouselController: controller.carouselController,
              options: CarouselOptions(
                height: Get.height,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: false,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  controller.currentIndex.value = index;
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
          ),
          Positioned(
            bottom: 30.0.sp,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [0, 1, 2].map((e) {
                        return Container(
                          width: 8.0.sp,
                          height: 8.0.sp,
                          margin: EdgeInsets.symmetric(horizontal: 4.0.sp),
                          decoration: BoxDecoration(
                            color: controller.currentIndex.value == e ? AppColors.colorButtonBlue : Colors.white,
                            borderRadius: BorderRadius.circular(4.0.sp),
                          ),
                        );
                      }).toList(),
                    )),
                SizedBox(height: 20.0.sp),
                Obx(() => TouchableWidget(
                      onPressed: controller.onPressButtonNext,
                      padding: const EdgeInsets.all(0.0),
                      width: 160.0.sp,
                      height: 44.0.sp,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(22.0.sp)),
                        image: const DecorationImage(
                          image: AssetImage(AppImages.bg_button),
                          fit: BoxFit.fill,
                        ),
                        boxShadow: [
                          CommonBoxShadow(
                            color: AppColors.colorButtonBlue.withOpacity(0.5),
                            spreadRadius: 6.0.sp,
                            blurRadius: 18.0.sp,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Text(
                        controller.currentIndex.value == 2 ? 'Continue' : 'Next',
                        style: TextStyle(
                          fontSize: 18.0.sp,
                          fontFamily: AppFonts.robotoMedium,
                          color: AppColors.white,
                        ),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}
