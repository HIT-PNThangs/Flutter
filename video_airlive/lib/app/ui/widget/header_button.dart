import 'package:flutter/material.dart';

import '../../res/image/app_images.dart';
import '../theme/app_colors.dart';

class HeaderButton extends StatelessWidget {
  final String? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final Function()? onPressed;
  final Widget? childWidget;
  final double? iconWidth;
  final double? iconHeight;
  final double? elevation;
  final bool? mini;

  const HeaderButton({
    this.onPressed,
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.childWidget,
    this.iconWidth,
    this.iconHeight,
    this.elevation,
    this.mini,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: mini ?? false,
      heroTag: null,
      elevation: elevation ?? 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      backgroundColor: backgroundColor ?? AppColors.transparent,
      onPressed: onPressed,
      child: Container(
        child: icon == null
            ? childWidget
            : Image.asset(
                icon ?? AppImages.ic_back,
                width: iconWidth,
                height: iconHeight,
                color: iconColor,
              ),
      ),
    );
  }
}
