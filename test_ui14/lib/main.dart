import 'package:flutter/material.dart';

import 'background.dart';
import 'data.dart';
import 'detail_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:
          ThemeData(primarySwatch: Colors.blue, platform: TargetPlatform.iOS),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List list = Data().getList();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Stack(
      children: <Widget>[
        Hero(
            tag: '110135',
            child: CustomPaint(
              size: Size(width, height),
              painter: Background(),
            )),
        Hero(
            tag: '110136',
            child: Align(
              alignment: Alignment.bottomRight,
              child: Image.asset(
                'assets/tree.png',
                scale: 4.0,
                color: const Color(0xFF222D57).withOpacity(0.4),
              ),
            )),
        Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(widget.title),
              centerTitle: false,
              elevation: 0.0,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 50.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Travel the worls',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                      Text(
                        'See the world\'s best places',
                        style: TextStyle(fontSize: 10.0, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: height / 7),
                      child: SizedBox(
                        height: 250.0,
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            dataObject data = list[index];
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(PageRouteBuilder(
                                    pageBuilder: (BuildContext context,
                                            Animation<double> animation,
                                            Animation<double>
                                                secondaryAnimation) =>
                                        Details(index),
                                    transitionsBuilder: (
                                      BuildContext context,
                                      Animation<double> animation,
                                      Animation<double> secondaryAnimation,
                                      Widget child,
                                    ) {
                                      return SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(1.0, 0.0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: SlideTransition(
                                          position: Tween<Offset>(
                                            begin: Offset.zero,
                                            end: const Offset(0.0, 1.0),
                                          ).animate(secondaryAnimation),
                                          child: child,
                                        ),
                                      );
                                    },
                                    transitionDuration:
                                        const Duration(milliseconds: 500)));
                              },
                              child: Hero(
                                  tag: '110135$index',
                                  child: Container(
//                                  height: 180.0,
                                    width: width / 1.8,
                                    decoration: BoxDecoration(
                                      color: Colors.black45,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          data.url,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                Colors.black.withAlpha(70),
                                            offset: const Offset(3.0, 6.0),
                                            blurRadius: 5.0)
                                      ],
                                    ),
                                    margin: const EdgeInsets.only(left: 20.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0, bottom: 20.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  Text(
                                                    data.placeName,
                                                    style: const TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight
                                                                .bold),
                                                  ),
                                                  Text(
                                                    'Subtitle ${data.placeName}',
                                                    style: const TextStyle(
                                                        fontSize: 10.0,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight
                                                                .normal),
                                                  ),
                                                ],
                                              )),
                                        )
                                      ],
                                    ),
                                  )),
                            );
                          },
                          scrollDirection: Axis.horizontal,
                          itemCount: list.length,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    //your elements here

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Upcomming events',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'See recent events',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.normal),
                          ),
                          SizedBox(
                            height: 16.0,
                          )
                        ],
                      ),
                    ),

                    SizedBox(
                      height: 100.0,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          dataObject data = list[index];

                          return Container(
                            width: 250.0,
                            decoration: BoxDecoration(
                                color:
                                    const Color(0xFFF0F1F6).withOpacity(0.9),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5.0))),
                            margin: const EdgeInsets.only(left: 10.0),
                            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Row(
                              children: <Widget>[
                                Image.network(
                                  data.url,
                                  width: 72.0,
                                  height: 72.0,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(
                                  width: 4.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 14.0,
                                      ),
                                      Text(
                                        data.placeName,
                                        style: const TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Description about this place ${data.placeName}',
                                        style: const TextStyle(
                                            fontSize: 10.0,
                                            fontStyle: FontStyle.italic),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        itemCount: list.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 16.0,
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }
}
