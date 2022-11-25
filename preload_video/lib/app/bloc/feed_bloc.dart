import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

import '../model/feed_response.dart';
import '../repository/repository.dart';

class FeedBloc {
  final UserRepository repository = UserRepository();
  final BehaviorSubject<FeedResponse> _subject = BehaviorSubject<FeedResponse>();

  getFeeds() async {
    FeedResponse response = await repository.getFeeds();
    print(response.feeds);
    _subject.sink.add(response);
  }

  drainStream() {
    _subject.value = FeedResponse([], "");
  }

  @mustCallSuper
  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<FeedResponse> get subject => _subject;
}

final feedBloc = FeedBloc();