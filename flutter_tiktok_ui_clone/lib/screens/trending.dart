import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/api.dart';
import '../models/tiktok.dart';
import 'tiktokvideo.dart';

class Trending extends StatefulWidget {
  const Trending({super.key});

  @override
  _TrendingState createState() => _TrendingState();
}

class _TrendingState extends State<Trending> {
  PageController pageController = PageController();
  RequestController api = RequestController();
  List<Widget> tikTokVideos = [];

  getTrending() async {
    var cookies = await api.getCookie();
    api.setCookie(cookies);
    try {
      var response = await http.get(
        Uri.parse(api.url),
        headers: api.headers,
      );
      Tiktok tiktok = Tiktok.fromJson(jsonDecode(response.body));
      for (var item in tiktok.body!.itemListData!) {
          setState(() {
            tikTokVideos.add(TikTokVideo(data: item));
          });
        }
    } catch (ex) {
      print(ex);
    }
  }

  @override
  void initState() {
    super.initState();
    getTrending();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.vertical,
      controller: pageController,
      children: tikTokVideos.isEmpty
          ? <Widget>[
              Container(
                color: Colors.black,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ]
          : tikTokVideos,
    );
  }
}
