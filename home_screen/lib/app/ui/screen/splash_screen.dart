
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/splash_controller.dart';
import '../../../util/extensions.dart';
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
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                AppImages.ic_logo,
                width: Get.width / 4,
                height: Get.height / 4,
                fit: BoxFit.scaleDown,
              ),
              Text(
                'Airlive - Wallpaper',
                style: TextStyle(
                  color: AppColors.orange,
                  fontSize: 16.0.sp,
                  fontFamily: AppFonts.robotoRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
