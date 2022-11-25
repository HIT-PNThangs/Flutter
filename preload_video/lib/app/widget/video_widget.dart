import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final String videoUrl;

  const VideoWidget({Key? key, required this.videoUrl}) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  late Future<void> _initializeVideoPlayer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayer = videoPlayerController.initialize().then((value) {
      setState(() {});
    });

    videoPlayerController.play();
    videoPlayerController.setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayer,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return videoPlayerController.value.isInitialized
              ? SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: videoPlayerController.value.size.width,
                      height: videoPlayerController.value.size.height,
                      child: VideoPlayer(videoPlayerController),
                    ),
                  ),
                )
              : Container();
        } else {
          return Container();
        }
      },
    );
  }
}
