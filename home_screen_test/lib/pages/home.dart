import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_screen_test/app/controller/app_controller.dart';
import 'package:home_screen_test/posts/mypost_1.dart';
import 'package:home_screen_test/posts/mypost_2.dart';
import 'package:home_screen_test/posts/mypost_3.dart';
import 'package:home_screen_test/util/item_template.dart';

class HomeScreen extends StatelessWidget {
  final _controller = PageController(initialPage: 0);

  HomeScreen({super.key});

  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: const [
          MyPost1(),
          MyPost2(),
          MyPost3(),
          MyPost1(),
          MyPost2(),
          MyPost3(),
          MyPost1(),
          MyPost2(),
          MyPost3(),
          MyPost1(),
          MyPost2(),
          MyPost3(),
          MyPost1(),
          MyPost2(),
          MyPost3(),
          MyPost1(),
          MyPost2(),
          MyPost3(),
          MyPost1(),
          MyPost2(),
          MyPost3(),
        ],
      ),
    );
  }
}
