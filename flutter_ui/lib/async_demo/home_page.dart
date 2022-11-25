import 'package:flutter/material.dart';

import 'futurebuilder/Test2Page.dart';
import 'setstate/Test1Page.dart';
import 'streambuilder/Test3Page.dart';
import 'streambuilder2/Test4Page.dart';

class AsyncHomePage extends StatefulWidget {
  @override
  _AsyncHomePageState createState() => _AsyncHomePageState();
}

class _AsyncHomePageState extends State<AsyncHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("demo"),
      ),
      body: Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Test1Page()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("setState()用法"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Test2Page()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("FutureBuilder()用法"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Test3Page()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("StreamBuilder()用法"),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Test4Page()));
            },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Text("StreamBuilder封装"),
            ),
          ),
        ],
      ),
    );
  }
}
