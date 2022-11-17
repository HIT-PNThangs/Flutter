import 'package:flutter/material.dart';

import 'util/transformer_page_view.dart';

class Zero extends StatelessWidget {
  const Zero({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Zero"),
        ),
        body: TransformerPageView(
          itemCount: 5,
          itemBuilder: (c, i) {
            return Text("$i");
          },
        ));
  }
}
