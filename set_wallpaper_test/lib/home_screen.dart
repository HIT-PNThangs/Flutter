import 'package:flutter/material.dart';
import 'package:set_wallpaper_test/item_template.dart';
import 'package:get/get.dart';

import 'common_image_network.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemTemplate(child: CommonImageNetwork(
      url: "https://i.ibb.co/wBcpJkC/misc-s1-40.jpg",
      height: Get.height,
      width: Get.width,
    ));
  }
}
