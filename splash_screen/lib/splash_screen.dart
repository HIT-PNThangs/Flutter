import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/app_container.dart';
import 'ui/app_image_widget.dart';
import 'ui/theme/app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
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
                  const SizedBox(height: 48.0),
                  const Text(
                    'Numerology',
                    style: TextStyle(
                      fontSize: 45.0,
                      color: AppColor.white,
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(
                "213",
                style: TextStyle(
                  color: AppColor.white,
                ),
              ),
            ),
            // Obx(() =>
            //   const Padding(
            //     padding: EdgeInsets.only(bottom: 20.0),
            //     child: Text(
            //       "213",
            //       style: TextStyle(
            //         color: AppColor.white,
            //       ),
            //     ),
            //   )),
          ],
        ),
      ),
    );
  }
}