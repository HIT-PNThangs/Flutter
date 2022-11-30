import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../util/extensions.dart';
import '../../controller/app_controller.dart';
import '../../controller/subscribe_controller.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_screen.dart';
import '../widget/touchable_widget.dart';

class SubscribeScreen extends GetView<SubscribeController> {
  SubscribeScreen({Key? key}) : super(key: key);

  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      mainBackgroundColor: AppColors.mainGray,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 24.0.sp,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.frame_image,
                    fit: BoxFit.fitWidth,
                  ),
                  SizedBox(height: 16.0.sp),
                  Text(
                    ' Unlimited hot & trend wallpapers',
                    style: TextStyle(
                      color: AppColors.orange,
                      fontSize: 16.0.sp,
                      fontFamily: AppFonts.robotoBold,
                    ),
                  ),
                  SizedBox(height: 8.0.sp),
                  buildRow('Unlock all wallpapers'),
                  buildRow('Update Hot - Trendy wallpapers'),
                  buildRow('Suitable for all devices'),
                  buildRow('No Ads & Cancel Anytime'),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.0.sp, left: 30.0.sp),
                      child: Text(
                        "PAY ONCE",
                        style: TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.bold, fontFamily: AppFonts.robotoRegular),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0.sp, left: 40.0.sp),
                      child: Text(
                        "${Get.find<AppController>().productDetailsFullPack.value.price} for Lifetime Access",
                        style: TextStyle(
                          fontSize: 18.0.sp,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25.0.sp),
                    child: Container(
                      height: 50.0.sp,
                      width: Get.width * 0.6,
                      decoration:
                          BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(16.0.sp), boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF000000),
                          offset: const Offset(0, 0),
                          blurRadius: 16.0.sp,
                        )
                      ]),
                      child: Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0.sp),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.0.sp,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
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
                      ],
                    ),
                  ),
                  SizedBox(height: 24.0.sp),
                ],
              ),
            ),
            Obx(() => controller.showClose.value == false
                ? const SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 8.0.sp),
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      Padding(
                        padding: EdgeInsets.only(right: 8.0.sp),
                        child: IconButton(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () {
                            Get.back();
                            controller.changeValueShowClose();
                          },
                          icon: SvgPicture.asset(
                            AppImages.ic_close,
                            height: 30.0.sp,
                            width: 30.0.sp,
                          ),
                        ),
                      ),
                    ])))
          ],
        ),
      ),
    );
  }

  Widget buildRow(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 4.0.sp),
      child: Row(
        children: [
          SizedBox(width: Get.width / 7),
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
              fontSize: 12.0.sp,
              fontFamily: AppFonts.robotoRegular,
            ),
          )
        ],
      ),
    );
  }
}
