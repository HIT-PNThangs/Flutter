import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../data/get_videos_api.dart';

part 'select_video_event.dart';
part 'select_video_state.dart';

class SelectVideoBloc extends Bloc<SelectVideoEvent, SelectVideoState> {
  SelectVideoBloc() : super(SelectVideoInitial());
  final repo = Api();

  Stream<SelectVideoState> mapEventToState(
    SelectVideoEvent event,
  ) async* {
    if (event is LoadVideos) {
      try {
        yield SelectVideoLoading();
        final getvideos = await repo.getVideos();
        yield SelectVideoLoaded(videos: getvideos.videos);
      } on ErrorModel catch (e) {
        yield SelectVideoError(error: e);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
