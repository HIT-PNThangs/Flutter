
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

import '../../model/feed_viewmodel.dart';
import '../../model/video.dart';
import '../../widgets/action_toolbar.dart';
import '../../widgets/description.dart';

class ViewVideo extends StatefulWidget {
  final int index;
  const ViewVideo({Key? key, required this.index}) : super(key: key);

  @override
  _ViewVideoState createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  final locator = GetIt.instance;
  final feedViewModel = GetIt.instance<FeedViewModel>();

  @override
  void initState() {
    feedViewModel.loadVideo(widget.index);

    feedViewModel.setInitialised(true);
    // feedViewModel.controller!.play();

    super.initState();
  }

  int videoIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FeedViewModel>.reactive(
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      initialiseSpecialViewModelsOnce: true,
      builder: (context, model, child) => videoScreen(),
      viewModelBuilder: () => feedViewModel,
    );
  }

  Widget videoScreen() {
    return WillPopScope(
      onWillPop: () async {
        feedViewModel.videos[widget.index].controller!.pause();
        feedViewModel.videos[videoIndex].controller!.pause();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: feedVideos(),
      ),
    );
  }

  Widget feedVideos() {
    return Stack(
      children: [
        PageView.builder(
          controller: PageController(
            initialPage: widget.index,
            viewportFraction: 1,
          ),
          itemCount: feedViewModel.videos.length,
          onPageChanged: (index) {
            index = index % (feedViewModel.videos.length);
            feedViewModel.changeVideo(index);
            setState(() {
              videoIndex = index;
            });
          },
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            index = index % (feedViewModel.videos.length);

            return videoCard(feedViewModel.videos[index]);
          },
        ),
      ],
    );
  }

  Widget videoCard(Video video) {
    return Stack(
      children: [
        video.controller != null
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
                  ),
                )),
              )
            : SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Container(
                    height: 70,
                    width: 70,
                    color: Colors.black,
                    child: const Center(
                        child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    )),
                  ),
                ),
              ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                VideoDescription(video.user, video.videoTitle, video.songName),
                ActionsToolbar(video.likes, video.comments,
                    "https://www.andersonsobelcosmetic.com/wp-content/uploads/2018/09/chin-implant-vs-fillers-best-for-improving-profile-bellevue-washington-chin-surgery.jpg"),
              ],
            ),
            const SizedBox(height: 20)
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    for(Video video in feedViewModel.videos) {
      video.controller?.dispose();
    }

    super.dispose();
  }
}
