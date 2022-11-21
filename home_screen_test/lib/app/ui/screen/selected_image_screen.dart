import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/home_controller.dart';
import 'package:home_screen_test/app/controller/selected_image_controller.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../res/image/app_images.dart';
import '../widget/common_screen.dart';

class SelectedImageScreen extends GetView<SelectedImageController> {
  SelectedImageScreen({super.key});

  HomeController homeController = HomeController();

  @override
  Widget build(BuildContext context) {
    double frameHeight = Get.height / 3 * 2;

    return CommonScreen(
      child: Scaffold(
        body: Stack(
          alignment: const Alignment(1, 1),
          children: [
            // Load image
            Obx(() => Image.file(
                  File(controller.link.value),
                  fit: BoxFit.cover,
                  width: frameHeight / 10 * 9,
                  height: frameHeight / 10 * 19,
                )),
            // In app purchase, Review, Share app button group
            Container(
              alignment: const Alignment(0.9, -1),
              child: Padding(
                padding: EdgeInsets.only(top: 15.0.wp, left: 2.0.wp),
                child: Container(
                  width: 12.0.wp,
                  height: 40.0.wp,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => homeController.onPressPremium(),
                        icon: SvgPicture.asset(
                          AppImages.crown,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Eye",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
                        },
                        icon: SvgPicture.asset(
                          AppImages.eyes,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () => homeController.onPressShare(),
                        icon: SvgPicture.asset(
                          AppImages.share_app,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // Set
            Padding(
              padding: EdgeInsets.only(bottom: 15.0.wp),
              child: Container(
                alignment: const Alignment(1, 1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 30.0.wp,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.orange, width: 2),
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(24.0.sp)),
                      child: TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(Colors.transparent),
                              backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                          onPressed: () {
                            Fluttertoast.showToast(
                                msg: "Set",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          },
                          child: Text(
                            "Set",
                            style: TextStyle(color: Colors.orange, fontSize: 12.0.sp),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
