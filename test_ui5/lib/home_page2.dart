import 'package:flutter/material.dart';

import 'refresh_indicator.dart';

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});

  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  //SliverList
  //SliverGrid
  //SliverPadding
  //SliverAppBar
  //SliverPersistentHeader
  // SliverToBoxAdapter
  //SliverFillViewport
  //SliverFillRemaining

//  ScrollController scrollController;

  @override
  void initState() {
    super.initState();
//    scrollController = ScrollController();
//    scrollController.addListener(() {
//      double max = scrollController.position.maxScrollExtent;
//      double current = scrollController.position.pixels;
//
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("微博国际版"),
      ),
      body: RefreshIndicator2(
        notificationPredicate: (notifation) {
          return true;
        },
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () => true);
        },
        child: NestedScrollView(
          headerSliverBuilder: (contex, _) {
            return [
              //sliver
              SliverToBoxAdapter(
                child: Container(
                  height: 2000,
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.only(top: 15, bottom: 15, left: 15),
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: const <Widget>[
                          FlutterLogo(),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "作者:AAA",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "沙发上东方时代粉色的沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费沙发上东方时代粉色的方式地方水电费方式地方水电费 水电费收到方水电费水电费 第三方水电费啊打人问问任务人",
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),

              SliverPersistentHeader(
                delegate: MyDelegate(),
                pinned: true,
              ),
            ];
          },
          body: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                padding: const EdgeInsets.all(15),
                child: Center(
                  child: Text(index.toString()),
                ),
              );
            },
            itemCount: 40,
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: 48,
      padding: const EdgeInsets.only(left: 15, right: 15),
      color: Colors.white,
      child: Row(
        children: const <Widget>[
          Text(
            "赞:1020",
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "评论:100",
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "转发:10",
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  double get maxExtent => 48;

  @override
  double get minExtent => 48;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
