import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

List items = [
  "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5",
  "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m",
  "https://drive.google.com/uc?export=download&id=13aLJ8g7fw-L8AY9lF01OqXJ27xzFJaKU",
  "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8",
  "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W",
  "https://drive.google.com/uc?export=download&id=1eOEBuLf7R1O1I4hqCkjlHOWJw0f9EouK"
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _snappedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        onPageChanged: (int page) {
          setState(() {
            _snappedPageIndex = page;
          });
        },
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              VideoPlayItem(
                videoUrl: items[index],
                snappedPageIndex: _snappedPageIndex,
                currentIndex: index,
              ),
            ],
          );
        });
  }
}

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
