import 'package:flutter/material.dart';
import 'package:whats_app_flutter/constants/colors.dart';

Widget GradientIconButton({
  IconData? iconData,
  required double size,
  int? counterText,
  String? text
}) {
  return Column(
    children: [
      Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                greenGradient.lightColor,
                greenGradient.darkColor,
              ])
          ),
          child: iconData != null ? Icon(
              iconData,
              color: Colors.white
          ) : counterText != null ? Center(child: Text(counterText.toString(), style: const TextStyle(color: Colors.white),)) : const SizedBox(),
      ),
      text != null ? const SizedBox(height: 10) : const SizedBox(),
      text != null ? Text(text, style: TextStyle(color: grayColor.lightColor)) : const SizedBox(),
    ],
  );
}

Widget StoryWidget({
  required String imageUrl,
  required double size,
  required String text,
  required bool showGreenStrip
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Column(
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: showGreenStrip ? Border.all(color: greenColor, width: 2) : null
          ),
          child: Padding(
            padding: EdgeInsets.all(showGreenStrip ? 2.2 : 0),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                )
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(text, style: TextStyle(color: grayColor.lightColor))
      ],
    ),
  );
}
