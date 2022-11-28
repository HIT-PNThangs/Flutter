import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import 'package:video_tiktok/twisting_dots/twisting_dots.dart';

import 'feed_viewmodel.dart';
import 'video.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final locator = GetIt.instance;
  locator.registerSingleton<FeedViewModel>(FeedViewModel());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();

  @override
  void initState() {
    feedViewModel.loadVideo(0);
    feedViewModel.loadVideo(1);
    feedViewModel.setInitialised(true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      disposeViewModel: false,
      builder: (context, model, child) => videoScreen(),
      viewModelBuilder: () => feedViewModel,
    );
  }

  Widget videoScreen() {
    return Scaffold(
      backgroundColor: GetIt.instance<FeedViewModel>().actualScreen == 0 ? Colors.black : Colors.white,
      body: PageView.builder(
        controller: PageController(
          initialPage: 0,
          viewportFraction: 1,
        ),
        itemCount: feedViewModel.videos.length,
        onPageChanged: (index) {
          index = index % (feedViewModel.videos.length);
          feedViewModel.changeVideo(index);
        },
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          index = index % (feedViewModel.videos.length);

          return videoCard(feedViewModel.videos[index]);
        },
      ),
    );
  }

  Widget videoCard(Video video) {
    return video.controller != null
        ? GestureDetector(
            onTap: () {
              if (video.controller!.value.isPlaying) {
                video.controller?.pause();
              } else {
                video.controller?.play();
              }
            },
            child: SizedBox.expand(
                child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: video.controller?.value.size.width ?? 0,
                      height: video.controller?.value.size.height ?? 0,
                      child: VideoPlayer(video.controller!),
                    ))))
        : const SizedBox(
            child: Center(
              child: TwistingDots(size: 50, leftDotColor: Colors.pink, rightDotColor: Colors.blue),
            ),
          );
  }

  @override
  void dispose() {
    // feedViewModel.controller?.dispose();
    super.dispose();
  }
}
