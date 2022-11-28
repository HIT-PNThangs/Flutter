import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'bloc/preload_bloc.dart';
import 'core/build_context.dart';
import 'core/constants.dart';
import 'injection.dart';
import 'service/api_service.dart';
import 'service/navigation_service.dart';
import 'video_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureInjection(Environment.prod);
  runApp(MyApp());
}

Future createIsolate(int index) async {
  // Set loading to true
  BlocProvider.of<PreloadBloc>(context, listen: false).add(const PreloadEvent.setLoading());

  ReceivePort mainReceivePort = ReceivePort();

  Isolate.spawn<SendPort>(getVideosTask, mainReceivePort.sendPort);

  SendPort isolateSendPort = await mainReceivePort.first;

  ReceivePort isolateResponseReceivePort = ReceivePort();

  isolateSendPort.send([index, isolateResponseReceivePort.sendPort]);

  final isolateResponse = await isolateResponseReceivePort.first;
  final urls = isolateResponse;

  // Update new urls
  BlocProvider.of<PreloadBloc>(context, listen: false).add(PreloadEvent.updateUrls(urls));
}

void getVideosTask(SendPort mySendPort) async {
  ReceivePort isolateReceivePort = ReceivePort();

  mySendPort.send(isolateReceivePort.sendPort);

  await for (var message in isolateReceivePort) {
    if (message is List) {
      final int index = message[0];

      final SendPort isolateResponseSendPort = message[1];

      final List<String> urls = await ApiService.getVideos(id: index + kPreloadLimit);

      isolateResponseSendPort.send(urls);
    }
  }
}

class MyApp extends StatelessWidget {
  final NavigationService _navigationService = getIt<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<PreloadBloc>()..add(const PreloadEvent.getVideosFromApi()),
      child: MaterialApp(
        key: _navigationService.navigationKey,
        debugShowCheckedModeBanner: false,
        home: const VideoPage(),
      ),
    );
  }
}
