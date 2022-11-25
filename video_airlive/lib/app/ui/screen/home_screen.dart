import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_airlive/app/ui/widget/video_player_item.dart';
import 'package:video_airlive/util/extensions.dart';

import '../../controller/app_controller.dart';
import '../../controller/home_controller.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
        isBlankScreen: false,
        isFixedSizeHeader: false,
        child: Stack(
          alignment: const Alignment(1, 1),
          children: [
            // load image
            PageView.builder(
              itemBuilder: (context, index) {
                return Obx(() => controller.listWallpapers[controller.currentIndexImage.value]['type'] == 0
                    ? CommonImageNetwork(
                        url: controller.listWallpapers[controller.currentIndexImage.value]['image'],
                        width: Get.width,
                        height: Get.height,
                        fit: BoxFit.cover,
                        loadingSize: 80.0.sp,
                      )
                    : VideoPlayerItem(videoUrl: controller.listWallpapers[controller.currentIndexImage.value]['video']));
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
                          scrollController: controller.scrollController,
                          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                            background: Colors.transparent,
                          ),
                          itemExtent: 80,
                          looping: true,
                          children: controller.listWallpapers
                              .map((e) => RotatedBox(
                                  quarterTurns: 1,
                                  child: CommonImageNetwork(
                                    url: e['image'],
                                    width: 32,
                                    height: 64,
                                  )))
                              .toList()),
                    )),
              ),
            ),
          ],
        ));
  }
}
