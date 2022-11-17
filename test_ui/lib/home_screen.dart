import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ui/extensions.dart';

import 'common_image_network.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.0.sp),
          child: CommonImageNetwork(
            url: "https://i.ibb.co/wBcpJkC/misc-s1-40.jpg",
            width: Get.width,
            height: Get.height,
          ),
        ),
        Container(
            alignment: const Alignment(-1, 1),
            child: Padding(
              padding: EdgeInsets.all(8.0.wp),
              child: Text('New'),
            ))
      ],
    );
  }
}
