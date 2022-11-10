import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_ui/screen/home_screen.dart';
import 'package:music_app_ui/screen/play_list_screen.dart';
import 'package:music_app_ui/screen/song_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PNT',
      theme: ThemeData(
        textTheme: Theme.of(context)
            .textTheme
            .apply(bodyColor: Colors.white, displayColor: Colors.white),
      ),
      home: const SongScreen(),
      // getPages: [
      //   GetPage(name: '/', page: () => const HomeScreen()),
      //   GetPage(name: '/song', page: () => const SongScreen()),
      //   GetPage(name: '/playlist', page: () => const PlayListScreen())
      // ],
    );
  }
}
