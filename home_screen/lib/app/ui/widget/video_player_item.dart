import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayItem extends StatefulWidget {
  final String videoUrl;

  const VideoPlayItem({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoPlayItem> createState() => _VideoPlayItemState();
}

class _VideoPlayItemState extends State<VideoPlayItem> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          _controller.play();
          _controller.setLooping(true);
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: double.infinity,
      child: _controller.value.isInitialized
          ? GestureDetector(
              onTap: () {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(
                  _controller,
                ),
              ),
            )
          : loadingVideo(),
    );
  }

  Widget loadingVideo() => Container(
        color: Colors.black,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
}
