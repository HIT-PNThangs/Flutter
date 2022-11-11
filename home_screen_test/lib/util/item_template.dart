import 'package:flutter/material.dart';
import 'package:home_screen_test/util/extensions.dart';

class ItemTemplate extends StatelessWidget {
  final image;
  final String categoryTitle;

  const ItemTemplate(
      {super.key, required this.image, required this.categoryTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          image,
          Padding(
            padding: EdgeInsets.only(top: 15.0.wp),
            child: Column(
              children: [
                Center(
                  child: Text(
                    categoryTitle,
                    style: TextStyle(color: Colors.white, fontSize: 14.0.sp),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: const [
              // Icon(Icons.),
              Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white54,
              )
            ],
          )
          // // user name and caption
          // Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Container(
          //     alignment: const Alignment(-1, 1),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Text('@$username',
          //             style: const TextStyle(
          //               fontWeight: FontWeight.bold,
          //               fontSize: 16,
          //             )),
          //         const SizedBox(
          //           height: 10,
          //         ),
          //         RichText(
          //           text: TextSpan(
          //             children: [
          //               TextSpan(
          //                   text: videoDescription,
          //                   style: const TextStyle(color: Colors.white)),
          //               const TextSpan(
          //                   text: ' #fyp #flutter',
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.white)),
          //             ],
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
