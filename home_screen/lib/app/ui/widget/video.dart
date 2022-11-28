import 'package:video_player/video_player.dart';

class Video {
  String url;

  VideoPlayerController? controller;

  Video({required this.url});

  Future<void> loadController() async {
    controller = VideoPlayerController.network(url);
    await controller?.initialize();
    controller?.setLooping(true);
  }
}
