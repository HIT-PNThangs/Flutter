import 'package:airlive/app/ui/theme/app_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_touchable.dart';


class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? text;
  final double? textSize;
  final FontStyle? textFontStyle;
  final Widget? child;
  final List<BoxShadow>? boxShadow;
  final LinearGradient? gradient;
  final Color? color;

  const AppButton(
      {Key? key,
      this.width,
      this.height,
      this.radius,
      this.padding,
      this.text,
      this.textSize,
      required this.onPressed,
      this.margin,
      this.child,
      this.boxShadow,
      this.gradient,
      this.color,
      this.textFontStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: AppTouchable(
        width: width,
        height: height,
        padding: padding,
        onPressed: onPressed,
        outlinedBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius ?? 0),
        ),
        decoration: BoxDecoration(
          color: color,
          // gradient: color == null ? (gradient ?? AppColors.orange) : null,
          borderRadius: BorderRadius.circular(radius ?? 0),
          boxShadow: boxShadow ??
              [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.25),
                  offset: const Offset(0, 0),
                  blurRadius: 4.0.sp,
                ),
              ],
        ),
        child: child ??
            Text(
              text ?? '',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize ?? 15.0.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
                fontStyle: textFontStyle ?? FontStyle.normal,
              ),
            ),
      ),
    );
  }
}
