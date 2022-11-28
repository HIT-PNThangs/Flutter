import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:video_player/video_player.dart';

import '../core/constants.dart';
import '../main.dart';
import '../service/api_service.dart';

part 'preload_bloc.freezed.dart';
part 'preload_event.dart';
part 'preload_state.dart';

@injectable
@prod
class PreloadBloc extends Bloc<PreloadEvent, PreloadState> {
  PreloadBloc() : super(PreloadState.initial());

  @override
  Stream<PreloadState> mapEventToState(
    PreloadEvent event,
  ) async* {
    yield* event.map(
      setLoading: (e) async* {
        yield state.copyWith(isLoading: true);
      },
      getVideosFromApi: (e) async* {
        /// Fetch first 5 videos from api
        final List<String> urls = await ApiService.getVideos();
        state.urls.addAll(urls);

        /// Initialize 1st video
        await _initializeControllerAtIndex(0);

        /// Play 1st video
        _playControllerAtIndex(0);

        /// Initialize 2nd video
        await _initializeControllerAtIndex(1);

        yield state.copyWith(reloadCounter: state.reloadCounter + 1);
      },
      // initialize: (e) async* {},
      onVideoIndexChanged: (e) async* {
        /// Condition to fetch new videos
        final bool shouldFetch = (e.index + kPreloadLimit) % kNextLimit == 0 &&
            state.urls.length == e.index + kPreloadLimit;

        if (shouldFetch) {
          createIsolate(e.index);
        }

        /// Next / Prev video decider
        if (e.index > state.focusedIndex) {
          _playNext(e.index);
        } else {
          _playPrevious(e.index);
        }

        yield state.copyWith(focusedIndex: e.index);
      },
      updateUrls: (e) async* {
        /// Add new urls to current urls
        state.urls.addAll(e.urls);

        /// Initialize new url
        _initializeControllerAtIndex(state.focusedIndex + 1);

        yield state.copyWith(
            reloadCounter: state.reloadCounter + 1, isLoading: false);
        log('🚀🚀🚀 NEW VIDEOS ADDED');
      },
    );
  }

  void _playNext(int index) {
    /// Stop [index - 1] controller
    _stopControllerAtIndex(index - 1);

    /// Dispose [index - 2] controller
    _disposeControllerAtIndex(index - 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(index);

    /// Initialize [index + 1] controller
    _initializeControllerAtIndex(index + 1);
  }

  void _playPrevious(int index) {
    /// Stop [index + 1] controller
    _stopControllerAtIndex(index + 1);

    /// Dispose [index + 2] controller
    _disposeControllerAtIndex(index + 2);

    /// Play current video (already initialized)
    _playControllerAtIndex(index);

    /// Initialize [index - 1] controller
    _initializeControllerAtIndex(index - 1);
  }

  Future _initializeControllerAtIndex(int index) async {
    if (state.urls.length > index && index >= 0) {
      /// Create new controller
      final VideoPlayerController controller =
          VideoPlayerController.network(state.urls[index]);

      /// Add to [controllers] list
      state.controllers[index] = controller;

      /// Initialize
      await controller.initialize();

      log('🚀🚀🚀 INITIALIZED $index');
    }
  }

  void _playControllerAtIndex(int index) {
    if (state.urls.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController controller = state.controllers[index]!;

      /// Play controller
      controller.play();

      log('🚀🚀🚀 PLAYING $index');
    }
  }

  void _stopControllerAtIndex(int index) {
    if (state.urls.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController controller = state.controllers[index]!;

      /// Pause
      controller.pause();

      /// Reset postiton to beginning
      controller.seekTo(const Duration());

      log('🚀🚀🚀 STOPPED $index');
    }
  }

  void _disposeControllerAtIndex(int index) {
    if (state.urls.length > index && index >= 0) {
      /// Get controller at [index]
      final VideoPlayerController? controller = state.controllers[index];

      /// Dispose controller
      controller?.dispose();

      if (controller != null) {
        state.controllers.remove(controller);
      }

      log('🚀🚀🚀 DISPOSED $index');
    }
  }
}
