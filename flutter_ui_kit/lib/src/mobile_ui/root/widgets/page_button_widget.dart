import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../gen/colors.gen.dart';

class PageButtonWidget extends StatelessWidget {
  final Function onPressed;
  final int page;

  const PageButtonWidget({Key? key, required this.onPressed, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        height: 56.r,
        width: 56.r,
        color: ColorName.grayC4,
        child: Center(
          child: Text(
            "$page",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
