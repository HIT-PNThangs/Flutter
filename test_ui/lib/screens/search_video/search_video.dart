import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

import '../select_video/video_preview.dart';
import 'bloc/search_video_bloc.dart';

class SearchVideos extends StatefulWidget {
  @override
  _SearchVideosState createState() => _SearchVideosState();
}

class _SearchVideosState extends State<SearchVideos> {
  bool title = false;

  Future<String> createFolderInAppDocDir(String folderName) async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final Directory appDocDirFolder = Directory('${appDocDir.path}/$folderName');

    if (await appDocDirFolder.exists()) {
      return appDocDirFolder.path;
    } else {
      final Directory appDocDirNewFolder = await appDocDirFolder.create(recursive: true);
      return appDocDirNewFolder.path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchVideoBloc, SearchVideoState>(builder: (context, state) {
      if (state is SearchVideoLoading) {
        return Scaffold(
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.0),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "Wait a Momment..",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      }
      if (state is SearchVideoLoaded) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            title: const Text(
              "Results",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.transparent,
          ),
          body: GridView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 9 / 16, crossAxisCount: 3, mainAxisSpacing: 1.5, crossAxisSpacing: 1.5),
            children: [
              ...state.videos.map(
                (video) => InkWell(
                  onTap: () async {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => VideoPreview(url: video.files.link)));
                  },
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(
                              video.thumbnail,
                            ),
                          ),
                        ),
                        foregroundDecoration: const BoxDecoration(
                          gradient: LinearGradient(
                            end: Alignment.center,
                            begin: Alignment.bottomRight,
                            colors: [
                              Colors.black,
                              Colors.transparent,
                            ],
                          ),
                        ),
                        alignment: Alignment.bottomRight,
                      ),
                      const Positioned(
                        bottom: 0,
                        right: 0,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(Icons.movie_creation_rounded, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
      if (state is SearchVideoError) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.black),
              elevation: 0,
            ),
            body: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.error.code.toString(),
                    style: const TextStyle(color: Colors.red, fontSize: 26),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    state.error.message,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ));
      } else {
        return const Scaffold();
      }
    });
  }
}
