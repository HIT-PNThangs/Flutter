import 'dart:io';

import 'package:airlive/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../controller/selected_image_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_screen.dart';
import '../widget/touchable_widget.dart';

class SelectedImageScreen extends GetView<SelectedImageController> {
  SelectedImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double frameHeight = Get.height / 3 * 2;

    return CommonScreen(
      child: Scaffold(
        body: Obx(() => controller.review.value == false
            ? Stack(
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
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () => controller.onPressPremium(),
                              icon: SvgPicture.asset(
                                AppImages.crown,
                              ),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                controller.getTime();
                                controller.changeValueReview();
                              },
                              icon: SvgPicture.asset(
                                AppImages.eyes,
                              ),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () => controller.onPressShare(),
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
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((context) => Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TouchableWidget(
                                                  onPressed: () => controller.applyWallpaper(0),
                                                  child: Text(
                                                    'Apply to Home screen',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 16.0.sp,
                                                      fontFamily: AppFonts.robotoRegular,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 1, color: AppColors.primary),
                                                TouchableWidget(
                                                  onPressed: () => controller.applyWallpaper(1),
                                                  child: Text(
                                                    'Apply to Lock screen',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 16.0.sp,
                                                      fontFamily: AppFonts.robotoRegular,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 1, color: AppColors.primary),
                                                TouchableWidget(
                                                  onPressed: () => controller.applyWallpaper(2),
                                                  child: Text(
                                                    'Apply to Both screens',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 16.0.sp,
                                                      fontFamily: AppFonts.robotoRegular,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 1, color: AppColors.primary),
                                                SizedBox(height: 24.0.sp),
                                              ],
                                            ),
                                          )));
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
              )
            : Stack(
                // alignment: const Alignment(1, 1),
                children: [
                  // Load image
                  Obx(() => Image.file(
                        File(controller.link.value),
                        fit: BoxFit.cover,
                        width: frameHeight / 10 * 9,
                        height: frameHeight / 10 * 19,
                      )),
                  // Back
                  Padding(
                    padding: EdgeInsets.only(top: 40.0.sp, left: 8.0.sp),
                    child: Container(
                      width: 30.0.sp,
                      height: 30.0.sp,
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: SvgPicture.asset(
                          AppImages.ic_back,
                          height: 30.0.sp,
                          width: 30.0.sp,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    ),
                  ),
                  // In app purchase, Review, Share app button group
                  Container(
                    alignment: const Alignment(0.9, -1),
                    child: Padding(
                      padding: EdgeInsets.only(top: 15.0.wp, left: 2.0.wp),
                      child: Container(
                        width: 12.0.wp,
                        height: 40.0.wp,
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () => controller.onPressPremium(),
                              icon: SvgPicture.asset(
                                AppImages.crown,
                              ),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () {
                                controller.getTime();
                                controller.changeValueReview();
                              },
                              icon: SvgPicture.asset(
                                AppImages.eyes1,
                              ),
                            ),
                            IconButton(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onPressed: () => controller.onPressShare(),
                              icon: SvgPicture.asset(
                                AppImages.share_app,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Time
                  Obx(() => Positioned(
                      top: 200,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              controller.strTime.value,
                              style: TextStyle(fontSize: 20.0.sp, color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.strDay.value,
                              style: TextStyle(fontSize: 12.0.sp, color: Colors.white),
                            )
                          ],
                        ),
                      ))),
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
                                  showModalBottomSheet(
                                      context: context,
                                      builder: ((context) => Container(
                                            padding: EdgeInsets.symmetric(horizontal: 16.0.sp),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                TouchableWidget(
                                                  onPressed: () => controller.applyWallpaper(0),
                                                  child: Text(
                                                    'Apply to Home screen',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 16.0.sp,
                                                      fontFamily: AppFonts.robotoRegular,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 1, color: AppColors.primary),
                                                TouchableWidget(
                                                  onPressed: () => controller.applyWallpaper(1),
                                                  child: Text(
                                                    'Apply to Lock screen',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 16.0.sp,
                                                      fontFamily: AppFonts.robotoRegular,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 1, color: AppColors.primary),
                                                TouchableWidget(
                                                  onPressed: () => controller.applyWallpaper(2),
                                                  child: Text(
                                                    'Apply to Both screens',
                                                    style: TextStyle(
                                                      color: AppColors.white,
                                                      fontSize: 16.0.sp,
                                                      fontFamily: AppFonts.robotoRegular,
                                                    ),
                                                  ),
                                                ),
                                                const Divider(height: 1, color: AppColors.primary),
                                                SizedBox(height: 24.0.sp),
                                              ],
                                            ),
                                          )));
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
              )),
      ),
    );
  }
}
