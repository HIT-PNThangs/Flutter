import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../controller/home_controller.dart';
import '../widget/common_image_network.dart';
import '../widget/item_template.dart';

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
          PageView.builder(
              controller: controller.imageController,
              itemCount: list.length,
              onPageChanged: (value) => {controller.changeIndex(value)},
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return ItemTemplate(
                    image: CommonImageNetwork(
                      url: list[index]['image'],
                      width: Get.width,
                      height: Get.height,
                      fit: BoxFit.cover,
                    ),
                    categoryTitle: title);
              }),
          // Padding(
          //   padding: EdgeInsets.only(bottom: 4.0.wp),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       SizedBox(
          //         height: 68.0.sp,
          //         child: ListView.builder(
          //             itemCount: list.length,
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.only(
          //                     right: 5, top: 5, bottom: 5, left: 5),
          //                 child: Obx(() => CommonImageNetwork(
          //                       url: list[controller.currentIndex.value]['image'],
          //                       fit: BoxFit.cover,
          //                     )),
          //               );
          //             }),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
