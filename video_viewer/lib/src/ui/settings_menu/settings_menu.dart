import 'package:flutter/material.dart';

import '../../data/repositories/video.dart';
import '../../domain/entities/settings_menu_item.dart';
import '../widgets/transitions.dart';
import 'main_menu.dart';
import 'widgets/caption_menu.dart';
import 'widgets/quality_menu.dart';
import 'widgets/secondary_menu.dart';
import 'widgets/speed_menu.dart';

class SettingsMenu extends StatelessWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = VideoQuery();
    final video = query.video(context, listen: true);
    final meta = query.videoMetadata(context);
    final items = meta.style.settingsStyle.items;

    final bool main = video.isShowingMainSettingsMenu;
    final List<bool> secondary = video.isShowingSecondarySettingsMenus;

    return Stack(children: [
      GestureDetector(
        onTap: () {
          final controller = query.video(context);
          controller.closeSettingsMenu();
          controller.showAndHideOverlay(true);
        },
        child: Container(color: Colors.black.withOpacity(0.32)),
      ),
      CustomOpacityTransition(
        visible: !main,
        child: GestureDetector(
          onTap: video.closeAllSecondarySettingsMenus,
          child: Container(color: Colors.transparent),
        ),
      ),
      CustomOpacityTransition(visible: main, child: const MainMenu()), //MAIN MENU
      CustomOpacityTransition(
        visible: secondary[0],
        child: const QualityMenu(),
      ),
      CustomOpacityTransition(
        visible: secondary[1],
        child: const SpeedMenu(),
      ),
      CustomOpacityTransition(
        visible: secondary[2],
        child: const CaptionMenu(),
      ),
      if (items != null)
        for (int i = 0; i < items.length; i++)
          CustomOpacityTransition(
            visible: secondary[i + kDefaultMenus],
            child: SecondaryMenu(
              width: items[i].secondaryMenuWidth,
              children: [items[i].secondaryMenu],
            ),
          ),
    ]);
  }
}
