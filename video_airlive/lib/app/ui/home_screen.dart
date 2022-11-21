import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_airlive/app/controller/home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: controller.listImage.map((element) => Chewie(controller: ChewieController(videoPlayerController: ),)).toList(),
      ),
    );
  }
}
