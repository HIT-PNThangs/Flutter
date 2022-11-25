import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayItem extends StatefulWidget {
  final String videoUrl;
  final int snappedPageIndex, currentIndex;

  const VideoPlayItem({Key? key, required this.videoUrl, required this.snappedPageIndex, required this.currentIndex})
      : super(key: key);

  @override
  State<VideoPlayItem> createState() => _VideoPlayItemState();
}

class _VideoPlayItemState extends State<VideoPlayItem> {
  late VideoPlayerController videoPlayerController;
  late Future _initializeVideoPlayer;
  bool _isPlaying = true;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    _initializeVideoPlayer = videoPlayerController.initialize();
    videoPlayerController.play();
    videoPlayerController.setVolume(1);
    videoPlayerController.setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.snappedPageIndex == widget.currentIndex ? videoPlayerController.play() : videoPlayerController.pause();

    return Container(
      color: Colors.blue,
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          if (snapshot == ConnectionState.done) {
            return GestureDetector(
              onTap: () {
                _isPlaying ? videoPlayerController.play() : videoPlayerController.pause();

                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              child: Stack(children: [
                VideoPlayer(videoPlayerController),
                Center(
                  child: IconButton(
                      onPressed: () {
                        videoPlayerController.play();
                        _isPlaying = true;
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white.withOpacity(0.5),
                        size: 60,
                      )),
                )
              ]),
            );
          } else {
            return Container(
              color: Colors.pink,
              child: const Center(child: CircularProgressIndicator(color: Colors.white)),
            );
          }
        },
      ),
    );
  }
}