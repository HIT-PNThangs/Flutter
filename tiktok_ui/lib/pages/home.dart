import 'package:flutter/material.dart';
import 'package:tiktok_ui/posts/mypost_1.dart';
import 'package:tiktok_ui/posts/mypost_2.dart';
import 'package:tiktok_ui/posts/mypost_3.dart';

class UserHomePage extends StatelessWidget {
  final _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        scrollDirection: Axis.horizontal,
        children: const [
          MyPost1(),
          MyPost2(),
          MyPost3(),
        ],
      ),
    );
  }
}
