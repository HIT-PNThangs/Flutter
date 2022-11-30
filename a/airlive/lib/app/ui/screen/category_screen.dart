import 'package:airlive/app/controller/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../util/extensions.dart';
import '../../controller/home_controller.dart';
import '../../res/image/app_images.dart';
import '../../route/app_pages.dart';
import '../widget/common_image_network.dart';
import '../widget/common_screen.dart';

class CategoryScreen extends GetView<HomeController> {
  CategoryScreen({Key? key}) : super(key: key);
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      child: Scaffold(
        body: Stack(children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            child: SizedBox(
              height: AppBar().preferredSize.height,
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
                        AppImages.ic_back,
                        height: 45.0.sp,
                        width: 45.0.sp,
                      )),
                  Row(
                    children: [
                      SvgPicture.asset(AppImages.category_icon),
                      Text(
                        "Category",
                        style: TextStyle(color: HexColor.fromHex("#FF7A00"), fontSize: 18.0.sp),
                      )
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Get.offAndToNamed(AppRoute.setting_screen);
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
          ),
          Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top + AppBar().preferredSize.height, left: 6.0.sp, right: 6.0.sp),
              child: GridView.builder(
                  itemCount: controller.listCommon.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 12.0.sp,
                    crossAxisSpacing: 8.0.sp,
                    childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height),
                  ),
                  itemBuilder: (context, index) {
                    if (controller.ad != null && index % 3 == 0 && index != 0) {
                      return Container(
                        height: 72.0,
                        alignment: Alignment.center,
                        child: AdWidget(ad: controller.ad!),
                      );
                    } else {
                      return Obx(() => GestureDetector(
                            onTap: () {
                              if (index != controller.currentIndexImage) {
                                controller.changeIndexCategory(index);
                                controller.changeIndexImage(0);
                                Get.back();
                              }
                            },
                            child: index == controller.currentIndexCategory.value
                                ? Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0.sp),
                                        child: CommonImageNetwork(
                                          url: controller.listCommon[index]['wallpapers'][0]['image'],
                                          width: 100.0.sp,
                                          height: 220.0.sp,
                                          loadingSize: 60.0.sp,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(6.0.sp),
                                        child: Container(
                                          alignment: const Alignment(1, -1),
                                          child: SvgPicture.asset(AppImages.ic_check),
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
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12.0.sp),
                                        child: CommonImageNetwork(
                                          url: controller.listCommon[index]['wallpapers'][0]['image'],
                                          width: 100.0.sp,
                                          height: 220.0.sp,
                                          loadingSize: 60.0.sp,
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
                                  ),
                          ));
                    }
                  })),
        ]),
      ),
    );
  }
}
