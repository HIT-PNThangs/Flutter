import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_screen.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  Widget _buildItemStep(String asset) {
    return Container(
      margin: EdgeInsets.only(
        top: 12.0.sp,
      ),
      width: Get.width - 25.0.sp,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0.sp),
        border: Border.all(
          width: 2.0,
          color: AppColors.white,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0.sp),
        child: Image.asset(asset),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      child: Container(
        height: Get.height,
        width: Get.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImages.bg_editor),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).padding.top + 16.0.sp),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0.sp),
                  child: IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => Get.back(),
                    icon: SvgPicture.asset(
                      AppImages.ic_close,
                      height: 30.0.sp,
                      width: 30.0.sp,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12.0.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 12.0.sp),
                    Text(
                      'How to set up a\nHD/Live Wallpaper',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24.0.sp,
                        fontFamily: AppFonts.robotoMedium,
                      ),
                    ),
                    SizedBox(height: 24.0.sp),
                    SizedBox(
                      width: Get.width - 25.0.sp,
                      child: Text(
                        'Step 1. Choose the HD/Live Wallpaper you like.',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.0.sp,
                          fontFamily: AppFonts.robotoRegular,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.0.sp),
                    SizedBox(
                      width: Get.width - 25.0.sp,
                      child: Text(
                        'Step 2. Press button "Apply wallpaper" to start setting wallpaper (or button "Download" to download gallery).',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.0.sp,
                          fontFamily: AppFonts.robotoRegular,
                        ),
                      ),
                    ),
                    _buildItemStep(AppImages.hint01),
                    SizedBox(height: 24.0.sp),
                    SizedBox(
                      width: Get.width - 25.0.sp,
                      child: Text(
                        'Step 3.1 (HD Wallpaper). Select the option to set the wallpaper for your device (With some phones, you cannot set the lock screen wallpaper directly from the app. Download the image to your device and set a wallpaper from the downloaded image in your gallery).',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.0.sp,
                          fontFamily: AppFonts.robotoRegular,
                        ),
                      ),
                    ),
                    _buildItemStep(AppImages.hint02),
                    SizedBox(height: 24.0.sp),
                    SizedBox(
                      width: Get.width - 25.0.sp,
                      child: Text(
                        'Step 3.2 (Live Wallpaper). Preview the wallpaper and press "Set wallpaper".',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.0.sp,
                          fontFamily: AppFonts.robotoRegular,
                        ),
                      ),
                    ),
                    _buildItemStep(AppImages.hint03),
                    SizedBox(height: 24.0.sp),
                    SizedBox(
                      width: Get.width - 25.0.sp,
                      child: Text(
                        'Step 4 (Live Wallpaper). Select the option to set the wallpaper for your device.',
                        style: TextStyle(
                          color: AppColors.white,
                          fontSize: 16.0.sp,
                          fontFamily: AppFonts.robotoRegular,
                        ),
                      ),
                    ),
                    _buildItemStep(AppImages.hint04),
                    SizedBox(height: 24.0.sp),
                    Text(
                      'Now check your screen.\nYou have a new HD/Live wallpaper',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 24.0.sp,
                        fontFamily: AppFonts.robotoItalic,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).padding.bottom + 24.0.sp),
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
