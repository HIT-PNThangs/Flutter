import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../controller/selected_image_controller.dart';
import '../../res/image/app_images.dart';

class ModalFit1 extends StatelessWidget {
  ModalFit1({Key? key}) : super(key: key);

  SelectedImageController selectedImageController = Get.find<SelectedImageController>();

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Apply to Home screen'),
            leading: SvgPicture.asset(AppImages.ic_apply_home),
            onTap: () => selectedImageController.applyWallpaper(0),
          ),
          ListTile(
            title: const Text('Apply to Lock screen'),
            leading: SvgPicture.asset(AppImages.ic_apply_look),
            onTap: () => selectedImageController.applyWallpaper(1),
          ),
          ListTile(
            title: const Text('Apply to Both Screen'),
            leading: SvgPicture.asset(AppImages.ic_apply_both),
            onTap: () => selectedImageController.applyWallpaper(2),
          ),
        ],
      ),
    ));
  }
}
