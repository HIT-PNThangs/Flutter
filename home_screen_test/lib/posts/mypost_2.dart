import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/util/item_template.dart';
import 'package:home_screen_test/util/post_template.dart';

class MyPost2 extends StatelessWidget {
  const MyPost2({super.key});

  @override
  Widget build(BuildContext context) {
    // return PostTemplate(
    //   username: 'zuckerberg',
    //   videoDescription: 'reels for days',
    //   numberOfLikes: '1.2M',
    //   numberOfComments: '232',
    //   numberOfShares: '122',
    //   userPost: Container(
    //     color: Colors.pink[300],
    //   ),
    // );

    return ItemTemplate(
      categoryTitle: 'Animal',
      image: Image.asset(
          width: Get.width,
          height: Get.height,
          'assets/test1.jpg'
      ),
    );
  }
}
