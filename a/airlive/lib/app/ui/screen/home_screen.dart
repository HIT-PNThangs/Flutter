import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../util/extensions.dart';
import '../../controller/app_controller.dart';
import '../../controller/home_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../../route/app_pages.dart';
import '../theme/app_colors.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';
import '../widget/touchable_widget.dart';
import '../widget/video_player_item.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
        child: Scaffold(
      body: Obx(() => controller.review.value == false
          ? Stack(
              alignment: const Alignment(1, 1),
              children: [
                // load image
                PageView.builder(
                  itemBuilder: (context, index) {
                    return controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
                        ? CommonImageNetwork(
                            url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                            width: Get.width,
                            height: Get.height,
                            fit: BoxFit.cover,
                            loadingSize: 80.0.sp,
                          )
                        : VideoPlayItem(
                            videoUrl: controller.listWallpapers[controller.currentIndexImage.value]['video'],
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
                              style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
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
                                          onTap: () => controller.onPressAlbum(),
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
                                          onTap: () => controller.onPressCameraPick(),
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
                                itemExtent: 80.0.sp,
                                looping: true,
                                children: controller.listWallpapers
                                    .map((e) => RotatedBox(
                                        quarterTurns: 1,
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                            e['image'],
                                          ),
                                          width: 32.0.sp,
                                          height: 80.0.sp,
                                        )))
                                    .toList()),
                          )),
                    )),
              ],
            )
          : Stack(
              alignment: const Alignment(1, 1),
              children: [
                // // load image
                // PageView.builder(
                //   physics: const NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     return controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
                //         ? CommonImageNetwork(
                //             url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                //             width: Get.width,
                //             height: Get.height,
                //             fit: BoxFit.cover,
                //             loadingSize: 80.0.sp,
                //           )
                //         : VideoPlayItem(
                //             videoUrl: controller.listWallpapers[controller.currentIndexImage.value]['video'],
                //             snappedPageIndex: controller.currentIndexImage.value,
                //             currentIndex: index,
                //           );
                //   },
                // ),
                PageView.builder(
                    controller: controller.loopPageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: ((context, index) {
                      return controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
                          ? Obx(() => CommonImageNetwork(
                                url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                                width: Get.width,
                                height: Get.height,
                                fit: BoxFit.cover,
                                loadingSize: 80.0.sp,
                              ))
                          : Obx(() => VideoPlayItem(
                              videoUrl: controller.listWallpapers[controller.currentIndexImage.value]['video']));
                    })),
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
                // Title
                Padding(
                  padding: EdgeInsets.only(top: 15.0.wp),
                  child: Column(
                    children: [
                      Center(
                        child: Obx(() => Text(
                              controller.title.value,
                              style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                            )),
                      )
                    ],
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
                                          onTap: () => controller.onPressAlbum(),
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
                                          onTap: () => controller.onPressCameraPick(),
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
                                itemExtent: 80.0.sp,
                                looping: true,
                                children: controller.listWallpapers
                                    .map((e) => RotatedBox(
                                        quarterTurns: 1,
                                        child: Image(
                                          image: CachedNetworkImageProvider(
                                            e['image'],
                                          ),
                                          width: 32.0.sp,
                                          height: 80.0.sp,
                                        )))
                                    .toList()),
                          )),
                    )),
              ],
            )),
    ));
  }
}
