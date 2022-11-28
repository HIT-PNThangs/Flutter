import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';

import 'video.dart';

class FeedViewModel extends BaseViewModel {
  List<Video> videos = [];

  int prevVideo = 0;
  int actualScreen = 0;

  FeedViewModel() {
    load();
    notifyListeners();
  }

  void load() async {
    videos = [
      Video(url: "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5"),
      Video(url: "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m"),
      Video(url: "https://drive.google.com/uc?export=download&id=13aLJ8g7fw-L8AY9lF01OqXJ27xzFJaKU"),
      Video(url: "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8"),
      Video(url: "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W"),
      Video(url: "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5"),
      Video(url: "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m"),
      Video(url: "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8"),
      Video(url: "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W"),
      Video(url: "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5"),
      Video(url: "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m"),
      Video(url: "https://drive.google.com/uc?export=download&id=13aLJ8g7fw-L8AY9lF01OqXJ27xzFJaKU"),
      Video(url: "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8"),
      Video(url: "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W"),
    ];

    await videos[0].loadController();
    videos[0].controller!.play();

    notifyListeners();
  }

  // Future<List<Video>> getVideoList() async {
  //   var videoList = <Video>[];
  //
  //   videoList = [
  //     Video(url: "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=13aLJ8g7fw-L8AY9lF01OqXJ27xzFJaKU"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1PrHMC9FPzYtDcW8A_hpA5NnqmrWPqdA5"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1f2esumdaTagWfLXS5HcHoABjNIdXmj1m"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=13aLJ8g7fw-L8AY9lF01OqXJ27xzFJaKU"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=1c88DqKAOT8CI7OXjzJBHKkzJiaJo9Tt8"),
  //     Video(url: "https://drive.google.com/uc?export=download&id=10Dnihdj0oC6LC5TfNBu5q-D-yqDSrF8W"),
  //   ];
  //
  //   notifyListeners();
  //
  //   return videoList;
  // }

  changeVideo(index) async {
    if (videos[prevVideo].controller != null) {
      videos[prevVideo].controller!.pause();
    }

    if (videos[index].controller == null) {
      await videos[index].loadController();
    }

    videos[index].controller!.play();
    prevVideo = index;

    if (prevVideo + 1 < videos.length) {
      await videos[prevVideo + 1].loadController();
    }

    notifyListeners();
  }

  void loadVideo(int index) async {
    if (videos.length > index) {
      await videos[index].loadController();
      videos[index].controller?.play();

      notifyListeners();
    }
  }

  void setActualScreen(index) {
    actualScreen = index;
    if (index == 0) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    }

    notifyListeners();
  }
}
