import 'package:category_screen/app/controller/app_controller.dart';
import 'package:category_screen/app/controller/category_controller.dart';
import 'package:category_screen/app/util/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../res/image/app_images.dart';
import 'widget/common_image_network.dart';

class CategoryScreen extends GetView<CategoryController> {
  CategoryScreen({Key? key}) : super(key: key);

  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    AppImages.setting,
                    height: 45.0.sp,
                    width: 45.0.sp,
                  )),
              Row(
                children: [
                  SvgPicture.asset(AppImages.category_icon),
                  Text(
                    "Category",
                    style: TextStyle(
                        color: HexColor.fromHex("#FF7A00"), fontSize: 18.0.sp),
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    Fluttertoast.showToast(
                        msg: "Click",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  },
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: SvgPicture.asset(
                    AppImages.setting,
                    height: 45.0.sp,
                    width: 45.0.sp,
                  )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top * 2, left: 6.0.sp, right: 6.0.sp),
          child: GridView.builder(
              itemCount: controller.listCommon.length,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height),
              ),
              itemBuilder: (context, index) => Stack(
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
                        ),
                      )
                    ],
                  )),
        ),
      ]),
    );
  }
}
