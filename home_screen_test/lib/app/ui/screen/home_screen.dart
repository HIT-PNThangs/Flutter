import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';
import 'package:loop_page_view/loop_page_view.dart';

import '../../controller/home_controller.dart';
import '../../res/image/app_images.dart';
import '../../route/app_pages.dart';
import '../widget/common_image_network.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = controller.data['title'];
    List list = controller.data['wallpapers'] ?? [];

    return Scaffold(
      body: Stack(
        alignment: const Alignment(1, 1),
        children: [
          LoopPageView.builder(
            controller: LoopPageController(initialPage: 0),
            itemCount: list.length,
            onPageChanged: (value) => {controller.changeIndex(value)},
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Obx(() => CommonImageNetwork(
                    url: list[controller.currentIndex.value]['image'],
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    fit: BoxFit.cover,
                  ));
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0.wp),
            child: Column(
              children: [
                Center(
                  child: Text(
                    title,
                    style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: const Alignment(0.9, -1),
            child: Padding(
              padding: EdgeInsets.only(top: 15.0.wp, left: 2.0.wp),
              child: Container(
                width: 10.0.wp,
                height: 28.0.wp,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24.0.sp)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "In App Purchare",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: SvgPicture.asset(AppImages.crown),
                    ),
                    SizedBox(height: 3.0.wp),
                    InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Eye",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      child: SvgPicture.asset(AppImages.eyes),
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 33.0.wp),
            child: Container(
              alignment: const Alignment(1, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24.0.sp)),
                    child: IconButton(
                      onPressed: () {
                        Fluttertoast.showToast(
                            msg: "Category",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);

                        Get.offAndToNamed(AppRoute.category_screen);
                      },
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
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent)),
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
                          style: TextStyle(
                              color: Colors.orange, fontSize: 12.0.sp),
                        )),
                  ),
                  SizedBox(
                    width: 5.0.wp,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24.0.sp)),
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
                      icon: SvgPicture.asset(AppImages.add),
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 6.0.wp),
            child: SizedBox(
              height: 64,
              child: RotatedBox(
                quarterTurns: -1,
                child: CupertinoPicker(
                  onSelectedItemChanged: (int value) {
                    controller.changeIndex(value);
                  },
                  itemExtent: 64,
                  looping: true,
                  children: list
                      .map((e) => RotatedBox(
                          quarterTurns: 1,
                          child: CommonImageNetwork(
                            url: e['image'],
                            width: 32,
                            height: 64,
                          )))
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
