import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:loading_gifs/loading_gifs.dart';

import '../../../util/extensions.dart';
import '../../controller/app_controller.dart';
import '../../controller/home_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../../route/app_pages.dart';
import '../theme/app_colors.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
        child: WillPopScope(
          onWillPop: () => controller.onWillPop(context),
          child: Scaffold(
      body: Obx(() => controller.review.value == false
            ? Stack(
                alignment: const Alignment(1, 1),
                children: [
                  // load image
                  PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    itemBuilder: (context, index) {
                      return controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
                          // Image
                          ? CommonImageNetwork(
                              url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                              width: Get.width,
                              height: Get.height,
                              fit: BoxFit.cover,
                              loadingSize: 80.0.sp,
                            )
                          // video
                          : Stack(
                              children: [
                                CommonImageNetwork(
                                  url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                  width: Get.width,
                                  height: Get.height,
                                  fit: BoxFit.cover,
                                  loadingSize: 25.0.sp,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      appController.onPressSetOrPlayVideo({
                                        "type": "Video",
                                        "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                        "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                                      });

                                      // Get.toNamed(AppRoute.preview_screen, arguments: {
                                      //   "type": "Video",
                                      //   "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                      //   "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                                      // });
                                    },
                                    child: SvgPicture.asset(
                                      AppImages.ic_logo,
                                      width: 80.0.sp,
                                      height: 80.0.sp,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                )
                              ],
                            );
                    },
                  ),
                  // Category title
                  Padding(
                    padding: EdgeInsets.only(top: 15.0.wp),
                    child: Column(
                      children: [
                        Center(
                          child: Obx(() => Text(
                                controller.title.value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0.sp,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(2.0, 2.0), //position of shadow
                                      blurRadius: 6.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                                    ),
                                    Shadow(
                                      offset: const Offset(-2.0, -2.0), //position of shadow
                                      blurRadius: 6.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
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
                        decoration:
                            BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
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
                              onPressed: () {
                                controller.onPressShare();
                              },
                              icon: SvgPicture.asset(
                                AppImages.share_app,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Set, Category, Add group button
                  Padding(
                    padding: EdgeInsets.only(bottom: 33.0.wp),
                    child: Container(
                      alignment: const Alignment(1, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.category_screen);
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: SvgPicture.asset(AppImages.category_icon),
                            ),
                          ),
                          SizedBox(
                            width: 5.0.wp,
                          ),
                          GestureDetector(
                            onTap: () {
                              String type = controller.listWallpapers[controller.currentIndexImage.value]['type'] == 1
                                  ? "Video"
                                  : "Image";
                              // Get.toNamed(AppRoute.preview_screen, arguments: {
                              //   "type": type,
                              //   "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                              //   "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                              // });
                              appController.onPressSetOrPlayVideo({
                                "type": type,
                                "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                              });
                            },
                            child: Image.asset(AppImages.ic_set, height: 40.0.sp, width: 96.0.sp),
                          ),
                          SizedBox(
                            width: 5.0.wp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                            child: IconButton(
                              onPressed: () {
                                // showDialog(context: context, builder: (BuildContext context) => addDialog(context));
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                    barrierColor: Colors.black.withOpacity(0.7),
                                    transitionDuration: const Duration(milliseconds: 200),
                                    pageBuilder:
                                        (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => appController.onPressAlbum(),
                                            child: Container(
                                                height: 40.0.sp,
                                                width: 180.0.sp,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff242424),
                                                    borderRadius: BorderRadius.circular(8.0.sp)),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 8.0.sp),
                                                    SvgPicture.asset(AppImages.show_an_image),
                                                    SizedBox(width: 8.0.sp),
                                                    DefaultTextStyle(
                                                        style: TextStyle(
                                                            color: AppColors.orange,
                                                            fontSize: 16.0.sp,
                                                            fontFamily: AppFonts.robotoLight),
                                                        child: const Text('Your album'))
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 8.0.sp,
                                          ),
                                          GestureDetector(
                                            onTap: () => appController.onPressCameraPick(),
                                            child: Container(
                                                height: 40.0.sp,
                                                width: 180.0.sp,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff242424),
                                                    borderRadius: BorderRadius.circular(8.0.sp)),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 8.0.sp),
                                                    SvgPicture.asset(AppImages.camera),
                                                    SizedBox(width: 8.0.sp),
                                                    DefaultTextStyle(
                                                        style: TextStyle(
                                                            color: AppColors.orange,
                                                            fontSize: 16.0.sp,
                                                            fontFamily: AppFonts.robotoLight),
                                                        child: const Text('Camera'))
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 24.0.sp,
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Container(
                                                height: 40.0.sp,
                                                width: 150.0.sp,
                                                decoration:
                                                    const BoxDecoration(shape: BoxShape.circle, color: Color(0xff242424)),
                                                child: SvgPicture.asset(AppImages.ic_close,
                                                    width: 28.0.sp, height: 28.0.sp, fit: BoxFit.scaleDown)),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: SvgPicture.asset(AppImages.add),
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Pick image
                  Padding(
                      padding: EdgeInsets.only(bottom: 6.0.wp),
                      child: SizedBox(
                        height: 64,
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: Obx(
                              () => CupertinoPicker(
                                  onSelectedItemChanged: (int value) {
                                    controller.changeIndexImage(value);
                                  },
                                  selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                                    background: Colors.transparent,
                                  ),
                                  itemExtent: 54.0.sp,
                                  looping: true,
                                  children: controller.listWallpapers
                                      .map((e) => RotatedBox(
                                            quarterTurns: 1,
                                            child: FadeInImage.assetNetwork(
                                              image: e['image'],
                                              placeholder: circularProgressIndicator,
                                              placeholderScale: 20,
                                            ),
                                          ))
                                      .toList()),
                            )),
                      )),
                ],
              )
            : Stack(
                alignment: const Alignment(1, 1),
                children: [
                  // // load image
                  PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    itemBuilder: (context, index) {
                      return controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
                          // Image
                          ? CommonImageNetwork(
                              url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                              width: Get.width,
                              height: Get.height,
                              fit: BoxFit.cover,
                              loadingSize: 80.0.sp,
                            )
                          // video
                          : Stack(
                              children: [
                                CommonImageNetwork(
                                  url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                  width: Get.width,
                                  height: Get.height,
                                  fit: BoxFit.cover,
                                  loadingSize: 25.0.sp,
                                ),
                                Center(
                                  child: GestureDetector(
                                    onTap: () {
                                      appController.onPressSetOrPlayVideo({
                                        "type": "Video",
                                        "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                        "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                                      });

                                      // Get.toNamed(AppRoute.preview_screen, arguments: {
                                      //   "type": "Video",
                                      //   "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                      //   "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                                      // });
                                    },
                                    child: SvgPicture.asset(
                                      AppImages.ic_logo,
                                      width: 80.0.sp,
                                      height: 80.0.sp,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                )
                              ],
                            );
                    },
                  ),
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
                              onPressed: () {
                                controller.onPressShare();
                              },
                              icon: SvgPicture.asset(
                                AppImages.share_app,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Category title
                  Padding(
                    padding: EdgeInsets.only(top: 15.0.wp),
                    child: Column(
                      children: [
                        Center(
                          child: Obx(() => Text(
                                controller.title.value,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0.sp,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(2.0, 2.0), //position of shadow
                                      blurRadius: 6.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                                    ),
                                    Shadow(
                                      offset: const Offset(-2.0, -2.0), //position of shadow
                                      blurRadius: 6.0, //blur intensity of shadow
                                      color: Colors.black.withOpacity(0.8), //color of shadow with opacity
                                    ),
                                  ],
                                ),
                              )),
                        )
                      ],
                    ),
                  ),
                  // Time
                  Obx(() => Positioned(
                      top: 120,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 8),
                            Text(
                              controller.strTime.value,
                              style: TextStyle(fontSize: 50.0.sp, color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              controller.strDay.value,
                              style: TextStyle(fontSize: 18.0.sp, color: Colors.white),
                            )
                          ],
                        ),
                      ))),
                  // Set, Category, Add group button
                  Padding(
                    padding: EdgeInsets.only(bottom: 33.0.wp),
                    child: Container(
                      alignment: const Alignment(1, 1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                            child: IconButton(
                              onPressed: () {
                                Get.toNamed(AppRoute.category_screen);
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: SvgPicture.asset(AppImages.category_icon),
                            ),
                          ),
                          SizedBox(
                            width: 5.0.wp,
                          ),
                          GestureDetector(
                            onTap: () {
                              String type = controller.listWallpapers[controller.currentIndexImage.value]['type'] == 1
                                  ? "Video"
                                  : "Image";
                              // Get.toNamed(AppRoute.preview_screen, arguments: {
                              //   "type": type,
                              //   "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                              //   "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                              // });
                              appController.onPressSetOrPlayVideo({
                                "type": type,
                                "image": controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                "video": controller.listWallpapers[controller.currentIndexImage.value]['video']
                              });
                            },
                            child: Image.asset(AppImages.ic_set, height: 40.0.sp, width: 96.0.sp),
                          ),
                          SizedBox(
                            width: 5.0.wp,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                            child: IconButton(
                              onPressed: () {
                                showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                                    barrierColor: Colors.black.withOpacity(0.7),
                                    transitionDuration: const Duration(milliseconds: 200),
                                    pageBuilder:
                                        (BuildContext buildContext, Animation animation, Animation secondaryAnimation) {
                                      return Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () => appController.onPressAlbum(),
                                            child: Container(
                                                height: 40.0.sp,
                                                width: 180.0.sp,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff242424),
                                                    borderRadius: BorderRadius.circular(8.0.sp)),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 8.0.sp),
                                                    SvgPicture.asset(AppImages.show_an_image),
                                                    SizedBox(width: 8.0.sp),
                                                    DefaultTextStyle(
                                                        style: TextStyle(
                                                            color: AppColors.orange,
                                                            fontSize: 16.0.sp,
                                                            fontFamily: AppFonts.robotoLight),
                                                        child: const Text('Your album'))
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 8.0.sp,
                                          ),
                                          GestureDetector(
                                            onTap: () => appController.onPressCameraPick(),
                                            child: Container(
                                                height: 40.0.sp,
                                                width: 180.0.sp,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xff242424),
                                                    borderRadius: BorderRadius.circular(8.0.sp)),
                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 8.0.sp),
                                                    SvgPicture.asset(AppImages.camera),
                                                    SizedBox(width: 8.0.sp),
                                                    DefaultTextStyle(
                                                        style: TextStyle(
                                                            color: AppColors.orange,
                                                            fontSize: 16.0.sp,
                                                            fontFamily: AppFonts.robotoLight),
                                                        child: const Text('Camera'))
                                                  ],
                                                )),
                                          ),
                                          SizedBox(
                                            height: 24.0.sp,
                                          ),
                                          GestureDetector(
                                            onTap: () => Get.back(),
                                            child: Container(
                                                height: 40.0.sp,
                                                width: 150.0.sp,
                                                decoration:
                                                    const BoxDecoration(shape: BoxShape.circle, color: Color(0xff242424)),
                                                child: SvgPicture.asset(AppImages.ic_close,
                                                    width: 28.0.sp, height: 28.0.sp, fit: BoxFit.scaleDown)),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: SvgPicture.asset(AppImages.add),
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Pick image
                  Padding(
                      padding: EdgeInsets.only(bottom: 6.0.wp),
                      child: SizedBox(
                        height: 64,
                        child: RotatedBox(
                            quarterTurns: -1,
                            child: Obx(
                              () => CupertinoPicker(
                                  onSelectedItemChanged: (int value) {
                                    controller.changeIndexImage(value);
                                  },
                                  selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                                    background: Colors.transparent,
                                  ),
                                  itemExtent: 54.0.sp,
                                  looping: true,
                                  children: controller.listWallpapers
                                      .map((e) => RotatedBox(
                                            quarterTurns: 1,
                                            child: FadeInImage.assetNetwork(
                                              image: e['image'],
                                              placeholder: circularProgressIndicator,
                                              placeholderScale: 20,
                                            ),
                                          ))
                                      .toList()),
                            )),
                      )),
                ],
              )),
    ),
        ));
  }
}
