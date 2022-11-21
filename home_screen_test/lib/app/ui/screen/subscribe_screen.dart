import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/subscribe_controller.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_box_shadow.dart';
import '../widget/common_screen.dart';
import '../widget/header_button.dart';
import '../widget/touchable_widget.dart';

class SubscribeScreen extends GetView<SubscribeController> {
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      mainBackgroundColor: AppColors.mainGray,
      child: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 32.0.sp,
              left: 12.0.sp,
              right: 12.0.sp,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 48.0.sp),
                  child: Image.asset(
                    AppImages.bg_pre_top,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 12.0.sp),
                Text(
                  'AIRLIVE PREMIUM',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 32.0.sp,
                    fontFamily: AppFonts.robotoBold,
                  ),
                ),
                buildRow('Unlock all wallpaper'),
                buildRow('Exclusive collections'),
                buildRow('Customization tools'),
                buildRow('Daily update'),
                buildRow('No ads'),
                SizedBox(height: 16.0.sp),
                Obx(() => controller.rxListIAPItem.value.isEmpty
                    ? const CircularProgressIndicator(color: AppColors.primary)
                    : Column(
                        children: controller.rxListIAPItem.value.map((e) {
                          String name = '${e.productId ?? ''} ${e.localizedPrice ?? ''}';

                          switch (e.productId) {
                            case 'wf_weekly':
                              name = 'Weekly ${e.localizedPrice}';
                              break;
                            case 'wf_monthly':
                              name = 'Monthly ${e.localizedPrice}';
                              break;
                            case 'wf_yearly':
                              name = 'Yearly ${e.localizedPrice}';
                              break;
                          }

                          return TouchableWidget(
                            onPressed: () => controller.onPressPurchase(e),
                            padding: const EdgeInsets.all(0.0),
                            margin: EdgeInsets.only(bottom: 24.0.sp),
                            width: MediaQuery.of(context).size.width / 5 * 3,
                            height: 54.0.sp,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(22.0.sp)),
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
                              name,
                              style: TextStyle(
                                fontSize: 18.0.sp,
                                fontFamily: AppFonts.robotoMedium,
                                color: AppColors.white,
                              ),
                            ),
                          );
                        }).toList(),
                      )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
                  child: Text(
                    'This subscription automatically renews after 3-days trial period for \$2.49/week, \$4.99/month and \$9.99/lifetime, you can cancel it anytime. Payment will be charged to your Google Play store account at the confirmation of purchase. Subscription automatically renews unless it is canceled at least 24 hours before the end of the current period. You can manage and cancel your subscriptions by going to your account settings on the Google Play store after purchase. Any unused part or time-span of a free trial period will be forfeited, as soon as you purchase a subscriptions.',
                    style: TextStyle(
                      fontSize: 10.0.sp,
                      fontFamily: AppFonts.robotoRegular,
                      color: AppColors.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.0.sp),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TouchableWidget(
                        onPressed: controller.onPressPrivacy,
                        child: Text(
                          'Privacy Policy',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontFamily: AppFonts.robotoRegular,
                            color: AppColors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TouchableWidget(
                        onPressed: controller.onPressTerm,
                        child: Text(
                          'Terms of Service',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontFamily: AppFonts.robotoRegular,
                            color: AppColors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TouchableWidget(
                        onPressed: controller.onPressRestore,
                        child: Text(
                          'Restore',
                          style: TextStyle(
                            fontSize: 12.0.sp,
                            fontFamily: AppFonts.robotoRegular,
                            color: AppColors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0.sp),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 16.0.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HeaderButton(
                  icon: AppImages.ic_close,
                  iconColor: AppColors.white,
                  onPressed: Get.back,
                  iconHeight: 30.0.sp,
                  iconWidth: 30.0.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRow(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 2.0.sp),
      child: Row(
        children: [
          SizedBox(width: Get.width / 5),
          Image.asset(
            AppImages.ic_check_subscriber,
            width: 20.0.sp,
            height: 20.0.sp,
            fit: BoxFit.contain,
          ),
          SizedBox(width: 12.0.sp),
          Text(
            text,
            style: TextStyle(
              color: AppColors.white,
              fontSize: 14.0.sp,
              fontFamily: AppFonts.robotoRegular,
            ),
          )
        ],
      ),
    );
  }
}
