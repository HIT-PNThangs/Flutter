
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meditation/constants.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BottomNavItem(
            src: "assets/icons/calendar.svg",
            text: "Today",
            press: () {},
            isActive: true,
          ),
          BottomNavItem(
            src: "assets/icons/gym.svg",
            text: "All Exercises",
            press: () {},
          ),
          BottomNavItem(
            src: "assets/icons/calendar.svg",
            text: "Today",
            press: () {},
          ),
        ],
      ),
    );
  }
}


class BottomNavItem extends StatelessWidget {
  final String src, text;
  final void Function() press;
  final bool isActive;

  const BottomNavItem({
    Key? key,
    required this.src,
    required this.text,
    required this.press,
    this.isActive = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            src,
            color: isActive ? kActiveIconColor : kTextColor,
          ),
          Text(
            text,
            style: TextStyle(
                color: isActive ? kActiveIconColor : kTextColor
            ),
          )
        ],
      ),
    );
  }
}