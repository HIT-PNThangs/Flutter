import 'dart:math' as Math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'app/screens/ProductListView.dart';
import 'buildin_transformers.dart';
import 'images.dart';
import 'util/index_controller.dart';
import 'util/transformer_page_view.dart';
import 'welcome.dart';
import 'zero.dart';

void main() => runApp(const MyApp());
List<Color> list = [Colors.yellow, Colors.green, Colors.blue];

List<String> images = [
  "assets/Hepburn2.jpg",
  "assets/Hepburn5.jpg",
  "assets/Hepburn4.jpg",
];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late IndexController _controller;

  final List<String> _types = [
    "AccordionTransformer",
    "ThreeDTransformer",
    "ScaleAndFadeTransformer",
    "ZoomInPageTransformer",
    "ZoomOutPageTransformer",
    "DeepthPageTransformer"
  ];

  late String _type;
  late FixedExtentScrollController controller;
  int _index = 0;
  double _viewportFraction = 1.0;

  @override
  void initState() {
    _controller = IndexController();

    _type = "AccordionTransformer";

    controller = FixedExtentScrollController();
    super.initState();
  }

  PageTransformer getTransformer() {
    switch (_type) {
      case 'AccordionTransformer':
        return AccordionTransformer();
      case 'ThreeDTransformer':
        return ThreeDTransformer();
      case 'ScaleAndFadeTransformer':
        return ScaleAndFadeTransformer();
      case 'ZoomInPageTransformer':
        return ZoomInPageTransformer();
      case 'ZoomOutPageTransformer':
        return ZoomOutPageTransformer();
      case 'DeepthPageTransformer':
        return DeepthPageTransformer();
    }
    throw Exception("Not a type");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          InkWell(
            child: const Text("route"),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (c) {
                return const ProductListView();
              }));
            },
          )
        ],
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _controller.move(Math.Random().nextInt(5));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Random"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (b) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text("images"),
                      ),
                      body: const ImageTest(),
                    );
                  }));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Image"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (b) {
                    return Scaffold(
                        appBar: AppBar(
                          title: const Text("welcome"),
                        ),
                        body: Welcome(index: 0));
                  }));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Welcome"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (b) {
                    return const Zero();
                  }));
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Zero"),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _controller.previous();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Preious"),
              ),
              const SizedBox(
                width: 8.0,
              ),
              ElevatedButton(
                onPressed: () {
                  _controller.next();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Next"),
              ),
              const SizedBox(
                width: 8.0,
              ),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (_) {
                        return CupertinoPicker(
                            scrollController: controller,
                            itemExtent: 30.0,
                            onSelectedItemChanged: (int index) {
                              setState(() {
                                controller = FixedExtentScrollController(
                                    initialItem: index);
                                _type = _types[index];
                                if (_type == 'ScaleAndFadeTransformer') {
                                  _viewportFraction = 0.8;
                                } else {
                                  _viewportFraction = 1.0;
                                }
                              });
                            },
                            children: _types.map((t) => Text(t)).toList());
                      });
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Animation"),
              ),
            ],
          ),
          Expanded(
              child: SizedBox(
            child: TransformerPageView(
                loop: false,
                index: _index,
                viewportFraction: _viewportFraction,
                controller: _controller,
                transformer: getTransformer(),
                onPageChanged: (int index) {
                  setState(() {
                    _index = index;
                  });
                },
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    images[index],
                    fit: BoxFit.fill,
                  );
                },
                itemCount: 3),
          ))
        ],
      ),
    );
  }
}
