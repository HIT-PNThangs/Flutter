import 'package:flutter/material.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../main.dart';
import '../texts.dart';
import '../transformers/transformers.dart';
import '../widget/card_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text(
          MyApp.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: TransformerPageView(
        scrollDirection: Axis.horizontal,
        curve: Curves.easeInBack,
        transformer: DeepthPageTransformer(),
        itemCount: Texts.urlImages.length,
        itemBuilder: (context, index) {
          final urlImage = Texts.urlImages[index];
          final title = Texts.titles[index];
          final subtitle = Texts.subtitles[index];

          return CardWidget(
            urlImage: urlImage,
            title: title,
            subtitle: subtitle,
          );
        },
      ),
    );
  }
}
