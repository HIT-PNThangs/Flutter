import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:splash_screen/ui/app_container.dart';
import 'package:splash_screen/ui/app_image_widget.dart';
import 'package:splash_screen/ui/theme/app_color.dart';

import 'splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return AppContainer(
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppImageWidget.asset(
                      path: "lib/res/ic_frame_by_time.png",
                      width: Get.width / 2),
                  SizedBox(height: 48.0.sp),
                  Text(
                    'Numerology',
                    style: TextStyle(
                      fontSize: 45.0.sp,
                      fontFamily: 'uvn_mua_thu',
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            Obx(() => Padding(
                  padding: EdgeInsets.only(bottom: 20.0.sp),
                  child: Text(
                    controller.version.value,
                    style: const TextStyle(
                      color: AppColor.white,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
