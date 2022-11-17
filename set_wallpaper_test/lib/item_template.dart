import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:set_wallpaper_test/extensions.dart';

import 'app/res/image/app_images.dart';

class ItemTemplate extends StatelessWidget {
  final Widget child;

  const ItemTemplate({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          child,
          Padding(
            padding: EdgeInsets.only(bottom: 33.0.wp),
            child: Container(
              alignment: const Alignment(1, 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 30.0.wp,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.orange, width: 2),
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(24.0.sp)),
                    child: TextButton(
                        style: ButtonStyle(
                            overlayColor: MaterialStateProperty.all(
                                const Color(0xFFFF7A00))),
                        onPressed: () {
                          
                        },
                        child: Text(
                          "Set",
                          style: TextStyle(
                              color: Colors.orange, fontSize: 12.0.sp),
                        )),
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
