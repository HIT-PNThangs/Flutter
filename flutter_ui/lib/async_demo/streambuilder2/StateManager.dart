import 'dart:async';

import 'NetState.dart';

class StateManager {
  StreamController<NetState>? streamController;

  StateManager() {
    streamController = StreamController();
  }

  void dispose() {
    if (streamController != null) {
      streamController?.close();
    }
  }

  void loadingDialog() {
    streamController?.sink.add(NetShowDialogState());
  }

  void loading() {
    streamController?.sink.add(NetLoadingState());
  }

  void error() {
    streamController?.sink.add(NetErrorState());
  }

  void content<T>(T t) {
    streamController?.sink.add(NetContentState<T>(t));
  }
}
