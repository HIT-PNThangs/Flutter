import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/home_controller.dart';
import 'package:home_screen_test/util/extensions.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../../route/app_pages.dart';
import '../theme/app_colors.dart';
import '../widget/common_box_shadow.dart';
import '../widget/common_screen.dart';
import '../widget/touchable_widget.dart';

class SettingScreen extends GetView<HomeController> {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: SizedBox(
              height: AppBar().preferredSize.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        AppImages.ic_back,
                      )),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppImages.setting,
                        height: 28.0.sp,
                        width: 28.0.sp,
                      ),
                      Text(
                        "Setting",
                        style: TextStyle(color: HexColor.fromHex("#FF7A00"), fontSize: 18.0.sp),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.offAndToNamed(AppRoute.category_screen);
                      },
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: SvgPicture.asset(
                        AppImages.category_icon,
                      )),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top + AppBar().preferredSize.height),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
              child: Column(
                children: [
                  SizedBox(height: 18.0.sp),
                  Container(
                    padding: EdgeInsets.all(12.0.sp),
                    decoration: BoxDecoration(
                      color: AppColors.mainGray,
                      borderRadius: BorderRadius.circular(16.0.sp),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000),
                          offset: const Offset(0, 0),
                          blurRadius: 16.0.sp,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AppImages.ic_logo1, width: 64.0.sp, height: 64.0.sp, fit: BoxFit.scaleDown),
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              DefaultTextStyle(
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: 16.0.sp,
                                  fontFamily: AppFonts.robotoMedium,
                                ),
                                child: const Text(
                                  'Unlock All Wallpapers',
                                ),
                              ),
                              SizedBox(height: 16.0.sp),
                              TouchableWidget(
                                onPressed: () => controller.onPressPremium(),
                                width: MediaQuery.of(context).size.width / 2,
                                height: 40.0.sp,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20.0.sp)),
                                  color: AppColors.primary,
                                  boxShadow: [
                                    CommonBoxShadow(
                                      color: AppColors.primary.withOpacity(0.3),
                                      spreadRadius: 3.0.sp,
                                      blurRadius: 9.0.sp,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: DefaultTextStyle(
                                  style: TextStyle(
                                    fontSize: 16.0.sp,
                                    fontFamily: AppFonts.robotoMedium,
                                    color: AppColors.white,
                                  ),
                                  child: const Text(
                                    'Go Premium',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.0.sp),
                  buildItemContainer(
                    onPressed: () => controller.onPressTutorial(),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.how_to_use,
                          width: 32.0.sp,
                          height: 32.0.sp,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12.0.sp),
                        DefaultTextStyle(
                            style: TextStyle(
                              color: AppColors.orange.withOpacity(0.9),
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                            ),
                            child: const Text(
                              'How to use',
                            ))
                      ],
                    ),
                  ),
                  buildItemContainer(
                    onPressed: () => controller.onPressPrivacy(),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.pivacy,
                          width: 32.0.sp,
                          height: 32.0.sp,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12.0.sp),
                        DefaultTextStyle(
                            style: TextStyle(
                              color: AppColors.orange.withOpacity(0.9),
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                            ),
                            child: const Text(
                              'Privacy Policy',
                            )),
                      ],
                    ),
                  ),
                  buildItemContainer(
                    onPressed: () => controller.onPressTerm(),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.term_of_condition,
                          width: 32.0.sp,
                          height: 32.0.sp,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12.0.sp),
                        DefaultTextStyle(
                            style: TextStyle(
                              color: AppColors.orange.withOpacity(0.9),
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                            ),
                            child: const Text(
                              'Term of conditions',
                            ))
                      ],
                    ),
                  ),
                  buildItemContainer(
                    onPressed: () => controller.onPressShare(),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.share_app,
                          width: 32.0.sp,
                          height: 32.0.sp,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12.0.sp),
                        DefaultTextStyle(
                            style: TextStyle(
                              color: AppColors.orange.withOpacity(0.9),
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                            ),
                            child: const Text(
                              'Share app',
                            ))
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0.sp),
                  SizedBox(
                    width: Get.width - 25.0.sp,
                    child: DefaultTextStyle(
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 20.0.sp,
                        fontFamily: AppFonts.robotoItalic,
                      ),
                      child: const Text(
                        'More apps',
                      ),
                    ),
                  ),
                  buildItemContainer(
                    onPressed: () => StoreRedirect.redirect(androidAppId: 'com.vietapps.watchface'),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                      child: Row(
                        children: [
                          Image.asset(
                            AppImages.ic_watch_face,
                            width: 60.0.sp,
                            height: 60.0.sp,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 12.0.sp),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextStyle(
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 18.0.sp,
                                    fontFamily: AppFonts.robotoRegular,
                                  ),
                                  child: const Text(
                                    'Watch Face\nWallpaper Gallery',
                                  ),
                                ),
                                SizedBox(height: 4.0.sp),
                                DefaultTextStyle(
                                  style: TextStyle(
                                    color: AppColors.white.withOpacity(0.5),
                                    fontSize: 12.0.sp,
                                    fontFamily: AppFonts.robotoRegular,
                                  ),
                                  child: const Text(
                                    "Feel free to customize watch faces on your own apple watch with up to 2000+ "
                                    "wallpapers from Watch Face Wallpaper Gallery app. Let's try it!!!",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildItemContainer(
                    onPressed: () => StoreRedirect.redirect(androidAppId: 'com.vietapps.gravityball'),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0.sp),
                            child: Image.asset(
                              AppImages.ic_gravity_ball,
                              width: 60.0.sp,
                              height: 60.0.sp,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 12.0.sp),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextStyle(
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 18.0.sp,
                                      fontFamily: AppFonts.robotoRegular,
                                    ),
                                    child: const Text(
                                      'Gravity Ball',
                                    )),
                                SizedBox(height: 4.0.sp),
                                DefaultTextStyle(
                                  style: TextStyle(
                                    color: AppColors.white.withOpacity(0.5),
                                    fontSize: 12.0.sp,
                                    fontFamily: AppFonts.robotoRegular,
                                  ),
                                  child: const Text(
                                    "Help the gravity ball find its way to the black hole despite the gravity "
                                    "and spikes?",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  buildItemContainer(
                    onPressed: () => StoreRedirect.redirect(androidAppId: 'com.vietapps.healthyfit'),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0.sp),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.0.sp),
                            child: Image.asset(
                              AppImages.ic_healthy_fit,
                              width: 60.0.sp,
                              height: 60.0.sp,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(width: 12.0.sp),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DefaultTextStyle(
                                    style: TextStyle(
                                      color: AppColors.primary,
                                      fontSize: 18.0.sp,
                                      fontFamily: AppFonts.robotoRegular,
                                    ),
                                    child: const Text(
                                      'HealthyFit - Fitness for your health',
                                    )),
                                SizedBox(height: 4.0.sp),
                                DefaultTextStyle(
                                    style: TextStyle(
                                      color: AppColors.white.withOpacity(0.5),
                                      fontSize: 12.0.sp,
                                      fontFamily: AppFonts.robotoRegular,
                                    ),
                                    child: const Text(
                                        "We created this application to target office workers, those who have little "
                                        "time and also those who are passionate about gym. "
                                        "Let's exercise with us!!!")),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18.0.sp),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Widget buildItemContainer({Widget? child, dynamic Function()? onPressed}) {
    return TouchableWidget(
      onPressed: onPressed,
      padding: EdgeInsets.all(8.0.sp),
      margin: EdgeInsets.only(top: 12.0.sp),
      decoration: BoxDecoration(
        color: AppColors.mainGray,
        borderRadius: BorderRadius.circular(16.0.sp),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000),
            offset: const Offset(0, 0),
            blurRadius: 16.0.sp,
          ),
        ],
      ),
      child: child,
    );
  }
}
