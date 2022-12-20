import 'package:flutter/material.dart';

import 'repository.dart';

class TravelPageWithImages extends StatefulWidget {
  const TravelPageWithImages({super.key});

  @override
  _TravelPageWithImagesState createState() => _TravelPageWithImagesState();
}

class _TravelPageWithImagesState extends State<TravelPageWithImages> {
  late PageController _pageController;
  late String _currentImage;
  final _images = getTours().map((tour) => tour.assetImage).toList();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _currentImage = _images.first;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        Positioned.fill(child: Image.asset(_currentImage, fit: BoxFit.cover)),
        PageView(
            onPageChanged: _onPageChanged,
            children: getTours()
                .map((tour) => Center(
                      child: Text(tour.name, textScaleFactor: 3, style: const TextStyle(color: Colors.white)),
                    ))
                .toList()),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: const <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: SizedBox(width: double.infinity, height: 100, child: FlutterLogo()),
              ),
              Text('travel guide', style: TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
          TextButton(child: const Text('open tour'), onPressed: () {})
        ]),
      ]),
    );
  }

  void _onPageChanged(int page) => setState(() => _currentImage = _images[page]);
}
