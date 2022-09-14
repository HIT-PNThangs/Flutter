import 'package:flutter/material.dart';
import 'package:whats_app_flutter/constants/colors.dart';
import 'package:whats_app_flutter/views/home/home_widgets.dart';

enum homeTiles { message, group }

Widget HomeListTile(
    {required BuildContext context,
    required String imageUrl,
    required String title,
    required String subTitle,
    required String time,
    required homeTiles tiles,
    int? messageCounter,
    bool isOnline = false}) {
  return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 8.0, bottom: 12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(imageUrl),
                      )),
                ),
                Positioned(
                  bottom: 3,
                  right: 3,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        color: greenColor),
                  ),
                )
              ],
            ),
            isOnline
                ? Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor(context).darkColor)),
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Text(time),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                subTitle,
                                style: TextStyle(color: grayColor.lightColor),
                              ),
                              messageCounter != null
                                  ? GradientIconButton(size: 20, counterText: 4)
                                  : const SizedBox(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ));
}
