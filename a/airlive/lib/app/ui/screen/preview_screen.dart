import 'package:airlive/app/controller/preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../util/extensions.dart';
import '../../controller/app_controller.dart';
import '../../res/image/app_images.dart';
import '../sheet/material_bottom_sheet.dart';
import '../sheet/modal_fit.dart';
import '../theme/app_colors.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';
import '../widget/video_player_item.dart';

class PreviewScreen extends GetView<PreviewController> {
  PreviewScreen({Key? key}) : super(key: key);

  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double frameHeight = height / 12 * 7;

    return CommonScreen(
      mainBackgroundColor: AppColors.mainGray,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 8.0.sp),
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
              )
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 24.0.sp),
                    padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
                    height: frameHeight,
                    child: Stack(
                      children: [
                        Obx(() => controller.type.value == "Image"
                            ? Center(
                                child: Obx(() => CommonImageNetwork(
                                      url: controller.urlImage.value,
                                      fit: BoxFit.cover,
                                      width: frameHeight / 20 * 9,
                                      height: frameHeight / 20 * 19,
                                    )))
                            : Center(
                                child: SizedBox(
                                    width: frameHeight / 20 * 9,
                                    height: frameHeight / 20 * 19,
                                    child: VideoPlayItem(
                                      videoUrl: controller.urlVideo.value,
                                    )

                                    // VideoPlayItem(
                                    //   videoUrl: controller.urlVideo.value,
                                    // ),
                                    ))),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: (width - (frameHeight / 20 * 9)) / 2 - 24.0.sp,
                              height: frameHeight,
                              color: AppColors.mainGray,
                            ),
                            Container(
                              width: (width - (frameHeight / 20 * 9)) / 2 - 24.0.sp,
                              height: frameHeight,
                              color: AppColors.mainGray,
                            ),
                          ],
                        ),
                        Center(
                          child: Image.asset(
                            AppImages.bg_frame_phone,
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.type.value == "Image") {
                        showMaterialModalBottomSheet(
                          expand: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) => ModalFit(),
                        );
                      } else {
                        controller.setLiveWallpaper();
                      }
                    },
                    child: Image.asset(
                      AppImages.ic_apply,
                      height: 60.0.sp,
                      width: 140.0.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.type == "Image") {
                        controller.downloadImage();
                      } else {
                        controller.downloadVideo();
                      }
                    },
                    child: Image.asset(
                      AppImages.ic_download,
                      height: 60.0.sp,
                      width: 140.0.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0.sp),
          Obx(() => !appController.isPremium.value ? controller.containerBanner.value : const SizedBox.shrink())
        ],
      ),
    );
  }
}
