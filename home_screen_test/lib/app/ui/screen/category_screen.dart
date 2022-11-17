import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/res/font/app_fonts.dart';
import 'package:home_screen_test/app/route/app_pages.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../../controller/app_controller.dart';
import '../../controller/category_controller.dart';
import '../../res/image/app_images.dart';
import '../widget/common_image_network.dart';

class CategoryScreen extends GetView<CategoryController> {
  CategoryScreen({Key? key}) : super(key: key);

  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppImages.ic_close),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.offAndToNamed(AppRoute.home_screen);
                  },
                  icon: SvgPicture.asset(
                    AppImages.ic_close,
                    height: 40.0.sp,
                    width: 40.0.sp,
                  )),
              Row(
                children: [
                  SvgPicture.asset(AppImages.category_icon),
                  Text(
                    "Category",
                    style: TextStyle(
                        fontFamily: AppFonts.robotoLight,
                        color: HexColor.fromHex("#FF7A00"),
                        fontSize: 18.0.sp),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    Get.offAndToNamed(AppRoute.setting_screen);
                  },
                  icon: SvgPicture.asset(
                    AppImages.setting,
                    height: 40.0.sp,
                    width: 40.0.sp,
                  )),
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
                          url: controller.listCommon[index]['wallpapers'][0]
                              ['image'],
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
        ],
      ),
    );
  }
}
