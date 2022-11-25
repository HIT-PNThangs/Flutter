import 'dart:io';
import 'dart:typed_data';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
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
  late ChewieController _chewieController;
  bool _isPlaying = true;
  String _videoPath = '';

  @override
  void initState() {
    // videoPlayerController = VideoPlayerController.network(widget.videoUrl);

    initVideo();
    super.initState();
  }

  void initVideo() async {
    Directory? directory = await getTemporaryDirectory();
    Directory directoryDownload = Directory('${directory.path}/AirLive/videosdl');
    bool check = await directoryDownload.exists();

    if (!check) {
      await directoryDownload.create(recursive: true);
    }

    final ByteData videoData = await NetworkAssetBundle(Uri.parse(widget.videoUrl)).load("");
    final Uint8List bytes = videoData.buffer.asUint8List();
    final buffer = bytes.buffer;
    _videoPath = '${directoryDownload.path}/${DateTime.now().millisecondsSinceEpoch}.mp4';
    File fileVideo = File(_videoPath);
    await fileVideo.writeAsBytes(buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    VideoPlayerController videoPlayerController = VideoPlayerController.file(fileVideo);
    if (videoPlayerController != null) {
      _initializeVideoPlayer = videoPlayerController.initialize();

      videoPlayerController.setVolume(0);

      _chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: true,
        showControls: true,
        showOptions: false,
        showControlsOnInitialize: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.snappedPageIndex == widget.currentIndex ? videoPlayerController.play() : videoPlayerController.pause();

    return Container(
      color: Colors.blue,
      child: FutureBuilder(
        future: _initializeVideoPlayer,
        builder: (context, snapshot) {
          // if (snapshot == ConnectionState.done) {
          //   return GestureDetector(
          //     onTap: () {
          //       _isPlaying ? videoPlayerController.play() : videoPlayerController.pause();
          //
          //       setState(() {
          //         _isPlaying = !_isPlaying;
          //       });
          //     },
          //     child: Stack(children: [
          //       VideoPlayer(videoPlayerController),
          //       Center(
          //         child: IconButton(
          //             onPressed: () {
          //               videoPlayerController.play();
          //               _isPlaying = true;
          //             },
          //             icon: Icon(
          //               Icons.play_arrow,
          //               color: Colors.white.withOpacity(0.5),
          //               size: 60,
          //             )),
          //       )
          //     ]),
          //   );
          // } else {
          //   return Container(
          //     color: Colors.pink,
          //     child: const Center(child: CircularProgressIndicator(color: Colors.white)),
          //   );
          // }

          return GestureDetector(
            onTap: () {
              _isPlaying ? videoPlayerController.play() : videoPlayerController.pause();

              setState(() {
                _isPlaying = !_isPlaying;
              });
            },
            child: Stack(children: [
              Chewie(
                controller: _chewieController,
              ),
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
        },
      ),
    );
  }
}
