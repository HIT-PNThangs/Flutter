import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/item_template.dart';
import 'package:home_screen_test/util/post_template.dart';

class MyPost3 extends StatelessWidget {
  const MyPost3({super.key});

  @override
  Widget build(BuildContext context) {
    // return PostTemplate(
    //   username: 'randomUser',
    //   videoDescription: 'flutter tutorial',
    //   numberOfLikes: '1.2B',
    //   numberOfComments: '232',
    //   numberOfShares: '122',
    //   userPost: Container(
    //     color: Colors.blue[300],
    //   ),
    // );

    return ItemTemplate(
      categoryTitle: 'Animal',
      image: Image.asset(
          width: Get.width,
          height: Get.height,
          'assets/test2.jpg'
      ),
    );
  }
}
