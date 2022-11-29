import 'package:airlive/app/controller/preview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../util/extensions.dart';
import '../../res/font/app_fonts.dart';
import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';
import '../widget/common_box_shadow.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';
import '../widget/touchable_widget.dart';
import '../widget/video_player_item.dart';

// class PreviewScreen extends StatelessWidget {
//   final String? type;
//   final String? link;
//   final Chewie? playerWidget;
//   final double? scaleVideo;
//   final Function()? onPressApply;
//   final Function()? onPressDownload;
//
//   const PreviewScreen(
//       {Key? key, this.type, this.link, this.playerWidget, this.scaleVideo, this.onPressApply, this.onPressDownload})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     double frameHeight = height / 12 * 7;
//     return CommonScreen(
//       mainBackgroundColor: AppColors.mainGray,
//       child: Column(
//         children: [
//           SizedBox(height: MediaQuery.of(context).padding.top),
//           Padding(
//             padding: EdgeInsets.only(top: 6.0.sp, left: 16.0.sp),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 HeaderButton(
//                   icon: AppImages.ic_close,
//                   iconColor: AppColors.white,
//                   onPressed: () => Navigator.of(context).pop(),
//                   iconHeight: 30.0.sp,
//                   iconWidth: 30.0.sp,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               child: Container(
//                 margin: EdgeInsets.symmetric(vertical: 24.0.sp),
//                 padding: EdgeInsets.symmetric(horizontal: 24.0.sp),
//                 height: frameHeight,
//                 child: Stack(
//                   children: [
//                     Center(
//                       child: type == 'URL'
//                           ? CommonImageNetwork(
//                               url: link,
//                               fit: BoxFit.cover,
//                               width: frameHeight / 20 * 9,
//                               height: frameHeight / 20 * 19,
//                             )
//                           : type == 'PATH'
//                               ? Image.file(
//                                   File(link ?? ''),
//                                   fit: BoxFit.cover,
//                                   width: frameHeight / 20 * 9,
//                                   height: frameHeight / 20 * 19,
//                                 )
//                               : const SizedBox.shrink(),
//                     ),
//                     Center(
//                       child: SizedBox(
//                         width: frameHeight / 20 * 9,
//                         height: frameHeight / 20 * 19,
//                         child: playerWidget != null
//                             ? Transform.scale(scale: scaleVideo ?? 1.0, child: playerWidget!)
//                             : const SizedBox.shrink(),
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Container(
//                           width: (width - (frameHeight / 20 * 9)) / 2 - 24.0.sp,
//                           height: frameHeight,
//                           color: AppColors.mainGray,
//                         ),
//                         Container(
//                           width: (width - (frameHeight / 20 * 9)) / 2 - 24.0.sp,
//                           height: frameHeight,
//                           color: AppColors.mainGray,
//                         ),
//                       ],
//                     ),
//                     Center(
//                       child: Image.asset(
//                         AppImages.bg_frame_phone,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           TouchableWidget(
//             onPressed: onPressApply,
//             padding: const EdgeInsets.all(0.0),
//             margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
//             height: 48.0.sp,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(24.0.sp)),
//               color: AppColors.primary,
//               boxShadow: [
//                 CommonBoxShadow(
//                   color: AppColors.black.withOpacity(0.3),
//                   spreadRadius: 3.0.sp,
//                   blurRadius: 9.0.sp,
//                   offset: const Offset(0, 0),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.lock, size: 24.0.sp, color: AppColors.white),
//                 SizedBox(width: 8.0.sp),
//                 Text(
//                   'Apply wallpaper',
//                   style: TextStyle(
//                     fontSize: 18.0.sp,
//                     fontFamily: AppFonts.robotoRegular,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 12.0.sp),
//           TouchableWidget(
//             onPressed: onPressDownload,
//             padding: const EdgeInsets.all(0.0),
//             margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
//             height: 48.0.sp,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(24.0.sp)),
//               color: AppColors.primary,
//               boxShadow: [
//                 CommonBoxShadow(
//                   color: AppColors.black.withOpacity(0.3),
//                   spreadRadius: 3.0.sp,
//                   blurRadius: 9.0.sp,
//                   offset: const Offset(0, 0),
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.lock, size: 24.0.sp, color: AppColors.white),
//                 SizedBox(width: 8.0.sp),
//                 Text(
//                   'Download',
//                   style: TextStyle(
//                     fontSize: 18.0.sp,
//                     fontFamily: AppFonts.robotoRegular,
//                     color: AppColors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 24.0.sp),
//         ],
//       ),
//     );
//   }
// }

class PreviewScreen extends GetView<PreviewController> {
  const PreviewScreen({Key? key}) : super(key: key);

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
              child: Container(
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
                            child: VideoPlayItem(
                              videoUrl: controller.urlVideo.value,
                            ),
                          )),
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
            ),
          ),
          TouchableWidget(
            onPressed: () {},
            padding: const EdgeInsets.all(0.0),
            margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
            height: 48.0.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0.sp)),
              color: AppColors.primary,
              boxShadow: [
                CommonBoxShadow(
                  color: AppColors.black.withOpacity(0.3),
                  spreadRadius: 3.0.sp,
                  blurRadius: 9.0.sp,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                if(controller.type.value == "Image") {
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
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 24.0.sp, color: AppColors.white),
                  SizedBox(width: 8.0.sp),
                  Text(
                    'Apply wallpaper',
                    style: TextStyle(
                      fontSize: 18.0.sp,
                      fontFamily: AppFonts.robotoRegular,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 12.0.sp),
          TouchableWidget(
            onPressed: () {},
            padding: const EdgeInsets.all(0.0),
            margin: EdgeInsets.symmetric(horizontal: 12.0.sp),
            height: 48.0.sp,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(24.0.sp)),
              color: AppColors.primary,
              boxShadow: [
                CommonBoxShadow(
                  color: AppColors.black.withOpacity(0.3),
                  spreadRadius: 3.0.sp,
                  blurRadius: 9.0.sp,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.lock, size: 24.0.sp, color: AppColors.white),
                SizedBox(width: 8.0.sp),
                Text(
                  'Download',
                  style: TextStyle(
                    fontSize: 18.0.sp,
                    fontFamily: AppFonts.robotoRegular,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0.sp),
        ],
      ),
    );
  }
}
