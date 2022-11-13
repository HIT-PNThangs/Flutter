import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../controller/splash_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_screen.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;

    return CommonScreen(
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bg_splash1),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 64.0.sp),
            SvgPicture.asset(
              AppImages.ic_logo,
              width: Get.width / 3,
              height: Get.height / 3,
            ),
            SizedBox(height: 32.0.sp),
            Text(
              'AirLive - 4K Live Wallpapers',
              style: TextStyle(
                color: AppColors.orange,
                fontSize: 24.0.sp,
                fontFamily: AppFonts.robotoMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
