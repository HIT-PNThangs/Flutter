import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/home_controller.dart';
import 'package:home_screen_test/util/extensions.dart';
import 'package:home_screen_test/app/ui/widget/item_template.dart';

import '../widget/common_image_network.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    String title = controller.data['title'];
    List list = controller.data['wallpapers'] ?? [];

    return Scaffold(
      body: Stack(
        alignment: const Alignment(1, 1),
        children: [
          PageView.builder(
            controller: pageController,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return ItemTemplate(
                  image: CommonImageNetwork(
                    url: list[index]['image'],
                    width: Get.width,
                    height: Get.height,
                  ),
                  categoryTitle: title);
            },
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.0.wp),
            child: SizedBox(
              height: 68.0.sp,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: pageController,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return CommonImageNetwork(
                    url: list[index]['image'],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
