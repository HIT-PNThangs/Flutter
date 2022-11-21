import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'theme/colors.dart';

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  final Size size;

  const VideoPlayerItem({Key? key, required this.size, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  late VideoPlayerController videoController;
  bool isShowPlaying = false;

  @override
  void initState() {
    super.initState();

    videoController = VideoPlayerController.asset(widget.videoUrl)
      ..initialize().then((value) {
        videoController.play();

        setState(() {
          isShowPlaying = false;
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    videoController.dispose();
  }

  Widget isPlaying() {
    return videoController.value.isPlaying && !isShowPlaying
        ? Container()
        : Icon(
            Icons.play_arrow,
            size: 80,
            color: white.withOpacity(0.5),
          );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          videoController.value.isPlaying ? videoController.pause() : videoController.play();
        });
      },
      child: SizedBox(
          height: widget.size.height,
          width: widget.size.width,
          child: Stack(
            children: <Widget>[
              Container(
                height: widget.size.height,
                width: widget.size.width,
                decoration: const BoxDecoration(color: black),
                child: Stack(
                  children: <Widget>[
                    VideoPlayer(videoController),
                    Center(
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: isPlaying(),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
