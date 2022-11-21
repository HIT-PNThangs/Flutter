import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'chewie_list_item.dart';

void main() => runApp(const MyApp());

const List list = [
  'lib/app/res/videos/video1.mp4',
  'lib/app/res/videos/video2.mp4',
  'lib/app/res/videos/video3.mp4',
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
          ChewieListItem(
            videoPlayerController: VideoPlayerController.asset('lib/app/res/videos/video1.mp4'),
            looping: true,
          ),
          const SizedBox(
            height: 15.0,
          ),
          ChewieListItem(
            videoPlayerController: VideoPlayerController.asset('lib/app/res/videos/video2.mp4'),
            looping: true,
          ),
          const SizedBox(
            height: 15.0,
          ),
          ChewieListItem(videoPlayerController: VideoPlayerController.asset('lib/app/res/videos/video3.mp4'), looping: true),
          const SizedBox(
            height: 15.0,
          ),
          // ChewieListItem(
          //     videoPlayerController: VideoPlayerController.network('https://www.youtube.com/watch?v=Ls6EBIR8hDE'),
          //     looping: true),
        ],
      ),
    );
  }
}
