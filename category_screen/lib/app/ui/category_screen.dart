import 'package:category_screen/app/controller/app_controller.dart';
import 'package:category_screen/app/controller/category_controller.dart';
import 'package:category_screen/app/ui/widget/common_image_network.dart';
import 'package:category_screen/app/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../res/image/app_images.dart';

class CategoryScreen extends GetView<CategoryController> {
  CategoryScreen({Key? key}) : super(key: key);

  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: EdgeInsets.all(5.0.wp),
      child: Stack(
        children: [
          Container(
            height: 30.0.wp,
            alignment: const Alignment(0, 0),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {}, icon: SvgPicture.asset(AppImages.close)),
              ],
            ),
          ),
          GridView.builder(
            itemCount: controller.listCommon.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0.sp),
                    child: CommonImageNetwork(
                      url: controller.listCommon[index]['wallpapers'][0]['image'],
                      width: 100.0.sp,
                      height: 220.0.sp,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                      alignment: const Alignment(-1, 1),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(controller.listCommon[index]['title']),
                      ))
                ],
              );
            },
          ),
        ],
      ),
    ));
  }
}
