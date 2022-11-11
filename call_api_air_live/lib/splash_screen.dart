import 'package:call_api_air_live/app/data/common_screen.dart';
import 'package:call_api_air_live/app/data/image/app_images.dart';
import 'package:call_api_air_live/app/data/util/app_colors.dart';
import 'package:call_api_air_live/app/data/util/extensions.dart';
import 'package:call_api_air_live/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            Image.asset(
              AppImages.ic_logo,
              width: Get.width / 3,
            ),
            SizedBox(height: 32.0.sp),
            Text(
              'AirLive - 4K Live Wallpapers',
              style: TextStyle(
                color: AppColors.orange,
                fontSize: 24.0.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
