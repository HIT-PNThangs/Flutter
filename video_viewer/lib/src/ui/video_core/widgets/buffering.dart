import 'package:flutter/material.dart';

import '../../../data/repositories/video.dart';
import '../../widgets/transitions.dart';

class VideoCoreBuffering extends StatelessWidget {
  const VideoCoreBuffering({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = VideoQuery();
    final video = query.video(context, listen: true);
    final style = query.videoStyle(context);

    return CustomOpacityTransition(
      visible: video.isBuffering,
      child: style.buffering,
    );
  }
}
