import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:home_screen_test/util/extensions.dart';

import '../app/res/image/app_images.dart';

class ItemTemplate extends StatelessWidget {
  final Widget image;
  final String categoryTitle;

  const ItemTemplate(
      {super.key, required this.image, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          image,
          Padding(
            padding: EdgeInsets.only(top: 15.0.wp),
            child: Column(
              children: [
                Center(
                  child: Text(
                    categoryTitle,
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
                            msg: "Camera",
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
            padding: EdgeInsets.only(bottom: 30.0.wp),
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
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      },
                      icon: SvgPicture.asset("assets/category_icon.svg"),
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
                                MaterialStateProperty.all(const Color(0xFFFF7A00))),
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
          )
        ],
      ),
    );
  }
}
