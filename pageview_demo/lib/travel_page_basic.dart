import 'package:flutter/material.dart';

import 'repository.dart';

class TravelPageBasic extends StatelessWidget {
  const TravelPageBasic({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: <Widget>[
        PageView(
            children: getTours()
                .map((tour) => Center(
                      child: Text(tour.name, textScaleFactor: 3),
                    ))
                .toList()),
        Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(
            children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: SizedBox(
                width: double.infinity, height: 100, child: FlutterLogo()),
          ),
          Text('travel guide')
            ],
          ),
          TextButton(child: const Text('open tour'), onPressed: () {})
        ]),
      ]),
    );
  }
}
