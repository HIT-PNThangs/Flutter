import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../controller/setting_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_box_shadow.dart';
import '../widget/touchable_widget.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.black2,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
        child: Column(
          children: [
            SizedBox(height: 40.0.sp),
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
                  SvgPicture.asset(
                    AppImages.ic_premium,
                    width: 64.0.sp,
                    height: 64.0.sp,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        Text(
                          'Get Premium Access',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontSize: 16.0.sp,
                            fontFamily: AppFonts.robotoMedium,
                          ),
                        ),
                        SizedBox(height: 16.0.sp),
                        TouchableWidget(
                          onPressed: () {},
                          padding: const EdgeInsets.all(0.0),
                          width: MediaQuery.of(context).size.width / 2,
                          height: 40.0.sp,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0.sp)),
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
                          child: Text(
                            'Upgrade Now',
                            style: TextStyle(
                              fontSize: 16.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                              color: AppColors.white,
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
              onPressed: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImages.how_to_use,
                    width: 40.0.sp,
                    height: 40.0.sp,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 12.0.sp),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'How to use',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.6),
                        fontSize: 18.0.sp,
                        fontFamily: AppFonts.robotoMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            buildItemContainer(
              onPressed: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImages.pivacy,
                    width: 40.0.sp,
                    height: 40.0.sp,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 12.0.sp),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.6),
                      fontSize: 18.0.sp,
                      fontFamily: AppFonts.robotoMedium,
                    ),
                  ),
                ],
              ),
            ),
            buildItemContainer(
              onPressed: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImages.term_of_condition,
                    width: 40.0.sp,
                    height: 40.0.sp,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 12.0.sp),
                  Text(
                    'Term of conditions',
                    style: TextStyle(
                      color: AppColors.white.withOpacity(0.6),
                      fontSize: 18.0.sp,
                      fontFamily: AppFonts.robotoMedium,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: buildItemContainer(
                    onPressed: () {},
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.contact_us,
                          width: 40.0.sp,
                          height: 40.0.sp,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12.0.sp),
                        Expanded(
                          child: Text(
                            'Contact us',
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 12.0.sp),
                Expanded(
                  flex: 1,
                  child: buildItemContainer(
                    onPressed: () {},
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.share_app,
                          width: 40.0.sp,
                          height: 40.0.sp,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 12.0.sp),
                        Expanded(
                          child: Text(
                            'Share app',
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.6),
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoMedium,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            buildItemContainer(
              onPressed: () {},
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppImages.language,
                    width: 40.0.sp,
                    height: 40.0.sp,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 12.0.sp),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'Language',
                      style: TextStyle(
                        color: AppColors.white.withOpacity(0.6),
                        fontSize: 18.0.sp,
                        fontFamily: AppFonts.robotoMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0.sp),
            SizedBox(
              width: Get.width - 25.0.sp,
              child: Text(
                'More apps',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20.0.sp,
                  fontFamily: AppFonts.robotoItalic,
                ),
              ),
            ),
            buildItemContainer(
              onPressed: () {},
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
                          Text(
                            'Watch Face\nWallpaper Gallery',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoRegular,
                            ),
                          ),
                          SizedBox(height: 4.0.sp),
                          Text(
                            "Feel free to customize watch faces on your own apple watch with up to 2000+ wallpapers from Watch Face Wallpaper Gallery app. Let's try it!!!",
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 12.0.sp,
                              fontFamily: AppFonts.robotoRegular,
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
              onPressed: () {},
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
                          Text(
                            'Gravity Ball',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoRegular,
                            ),
                          ),
                          SizedBox(height: 4.0.sp),
                          Text(
                            "Help the gravity ball find its way to the black hole despite the gravity and spikes?",
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 12.0.sp,
                              fontFamily: AppFonts.robotoRegular,
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
              onPressed: () {},
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
                          Text(
                            'HealthyFit - Fitness for your health',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 18.0.sp,
                              fontFamily: AppFonts.robotoRegular,
                            ),
                          ),
                          SizedBox(height: 4.0.sp),
                          Text(
                            "We created this application to target office workers, those who have little time and also those who are passionate about gym. Let's exercise with us!!!",
                            style: TextStyle(
                              color: AppColors.white.withOpacity(0.5),
                              fontSize: 12.0.sp,
                              fontFamily: AppFonts.robotoRegular,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 40.0.sp),
          ],
        ),
      ),
    );
  }
}
