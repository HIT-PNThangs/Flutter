import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/item_template.dart';

class MyPost1 extends StatelessWidget {
  const MyPost1({super.key});

  @override
  Widget build(BuildContext context) {
    return ItemTemplate(
      categoryTitle: 'Animal',
      image: Image.asset(
        width: Get.width,
        height: Get.height,
        'assets/test.jpg'
      ),
    );
  }
}
