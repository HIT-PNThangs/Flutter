import 'package:flutter/material.dart';
import 'package:slide_to_act/slide_to_act.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SlideAction(
            // borderRadius: 32,
            elevation: 0,
            innerColor: Colors.deepPurple,
            outerColor: Colors.deepPurple[200],
            text: "Slide to Unlock",
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24
            ),
            sliderRotate: false,
            sliderButtonIcon: const Icon(
              Icons.lock_open,
              color: Colors.white,
            ),
            onSubmit: () {

            },
          ),
        ),
      ),
    );
  }
}
