import 'package:flutter/material.dart';

import 'background.dart';
import 'data.dart';

class Details extends StatefulWidget {
  int index;

  Details(this.index, {super.key});

  @override
  PlaceDetails createState() => PlaceDetails();
}

class PlaceDetails extends State<Details> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    List list = Data().getList();
    dataObject data = list[widget.index];
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
                color: Colors.white,
              ),
            )),
        ClipPath(
          clipper: ArcClipper(),
          child: Image.network(
            data.url,
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
            appBar: AppBar(
              title: const Text(''),
              backgroundColor: Colors.transparent,
              elevation: 0.0,
            ),
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: EdgeInsets.only(top: height / 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Hero(
                    tag: '110135${widget.index}',
                    child: Container(
                      width: width / 2,
                      height: height / 4,
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
                              color: Colors.black.withAlpha(70),
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
                                padding:
                                    const EdgeInsets.only(left: 20.0, bottom: 20.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      data.placeName,
                                      style: const TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Subtitle ${data.placeName}',
                                      style: const TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height / 30,
                        left: width / 20,
                        right: width / 20),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white30,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              data.placeName,
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            const Divider(
                              color: Colors.white,
                            ),
                            Text(
                              data.desc,
                              style: const TextStyle(
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 30);

    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width - (size.width / 4), size.height);
    var secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
