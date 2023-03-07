import 'package:flutter/material.dart';

import '../auto_text_size/auto_size_text.dart';
import 'animated_input.dart';
import 'text_card.dart';
import 'utils.dart';

class MaxLinesDemo extends StatelessWidget {
  final bool richText;

  const MaxLinesDemo(this.richText, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedInput(
      text: 'This String will be automatically resized to fit on two lines.',
      builder: (input) {
        return Row(
          children: <Widget>[
            Expanded(
              child: TextCard(
                title: 'Text',
                child: !richText
                    ? Text(
                        input,
                        style: const TextStyle(fontSize: 30),
                      )
                    : Text.rich(
                        spanFromString(input),
                        style: const TextStyle(fontSize: 30),
                      ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextCard(
                title: 'AutoSizeText',
                child: !richText
                    ? AutoSizeText(
                        input,
                        style: const TextStyle(fontSize: 30),
                        maxLines: 2,
                      )
                    : AutoSizeText.rich(
                        spanFromString(input),
                        style: const TextStyle(fontSize: 30),
                        maxLines: 2,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
