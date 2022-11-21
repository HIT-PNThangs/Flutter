import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../../controller/app_controller.dart';
import '../../controller/home_controller.dart';
import '../../res/image/app_images.dart';
import '../../route/app_pages.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';

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
            // load image
            LoopPageView.builder(
              controller: controller.loopPageController,
              itemCount: controller.listImage.length,
              onPageChanged: (value) => controller.changeImage(value),
              // physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Obx(() => controller.listImage[controller.currentIndexImage.value]['type'] == 1
                    ? Obx(() => CommonImageNetwork(
                          url: controller.listImage[controller.currentIndexImage.value]['image'],
                          width: Get.width,
                          height: Get.height,
                          fit: BoxFit.cover,
                        ))
                    : Obx(
                        () => Container(
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              "Video ${controller.currentIndexImage.value}",
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ));
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
                        onPressed: () {
                          Get.to(AppRoute.subscriber_screen);
                        },
                        icon: SvgPicture.asset(
                          AppImages.crown,
                        ),
                      ),
                      IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Eye",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
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
                          AppImages.share_app_home,
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
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
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
                            Fluttertoast.showToast(
                                msg: "Set",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                textColor: Colors.white,
                                fontSize: 16.0);
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
                      decoration:
                          BoxDecoration(color: Colors.black.withOpacity(0.5), borderRadius: BorderRadius.circular(24.0.sp)),
                      child: IconButton(
                        onPressed: () {
                          Fluttertoast.showToast(
                              msg: "Add",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              textColor: Colors.white,
                              fontSize: 16.0);
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
                          scrollController: controller.scrollController,
                          selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
                            background: Colors.transparent,
                          ),
                          itemExtent: 80,
                          looping: true,
                          children: controller.listImage
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
        ),
      ),
    );
  }
}
