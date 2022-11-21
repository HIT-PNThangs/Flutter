import 'package:flutter/material.dart';

import 'video_player_item.dart';

List items = [
  "assets/videos/video_1.mp4",
  "assets/videos/video_2.mp4",
  "assets/videos/video_3.mp4",
];

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return PageView(
      scrollDirection: Axis.vertical,
      children: items
          .map((e) => VideoPlayerItem(
                videoUrl: e,
                size: size,
              ))
          .toList(),
    );
  }
}
