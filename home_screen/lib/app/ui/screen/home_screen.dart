import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

import '../../controller/app_controller.dart';
import '../../controller/home_controller.dart';
import '../widget/common_screen.dart';
import '../widget/video_player_item.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      child: Scaffold(
        body: Stack(
          alignment: const Alignment(1, 1),
          children: [
            // // load image
            // if (controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0)
            //   Obx(() => CommonImageNetwork(
            //         url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
            //         width: Get.width,
            //         height: Get.height,
            //         fit: BoxFit.cover,
            //         loadingSize: 80.0.sp,
            //       ))
            // else
            //   Obx(() => VideoPlayItem(
            //         videoUrl: controller.listWallpapers[controller.currentIndexImage.value]['video'],
            //       )),
            // Padding(
            //   padding: EdgeInsets.only(top: 15.0.wp),
            //   child: Column(
            //     children: [
            //       Center(
            //         child: Obx(() => Text(
            //               controller.title.value,
            //               style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
            //             )),
            //       )
            //     ],
            //   ),
            // ),
            // PageView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) {
            //     return controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
            //         ? Obx(() => CommonImageNetwork(
            //               url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
            //               width: Get.width,
            //               height: Get.height,
            //               fit: BoxFit.cover,
            //               loadingSize: 80.0.sp,
            //             ))
            //         : Obx(() => VideoPlayItem(
            //               videoUrl: controller.listWallpapers[controller.currentIndexImage.value]['video'],
            //             ));
            //   },
            // ),
            PreloadPageView.builder(
              itemCount: controller.listVideo.length,
              itemBuilder: (context, index) {
                return VideoPlayItem(
                  videoUrl: controller.listVideo[index],
                );
              },
            ),
            // Padding(
            //     padding: EdgeInsets.only(bottom: 6.0.wp),
            //     child: SizedBox(
            //       height: 64,
            //       child: RotatedBox(
            //           quarterTurns: -1,
            //           child: Obx(
            //             () => CupertinoPicker(
            //                 onSelectedItemChanged: (int value) {
            //                   controller.changeIndexImage(value);
            //                 },
            //                 selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
            //                   background: Colors.transparent,
            //                 ),
            //                 itemExtent: 80.0.sp,
            //                 looping: true,
            //                 children: controller.listWallpapers
            //                     .map((e) => RotatedBox(
            //                         quarterTurns: 1,
            //                         child: Image(
            //                           image: CachedNetworkImageProvider(
            //                             e['image'],
            //                           ),
            //                           width: 32.0.sp,
            //                           height: 80.0.sp,
            //                         )))
            //                     .toList()),
            //           )),
            //     ))
          ],
        ),
      ),
    );
  }
}
