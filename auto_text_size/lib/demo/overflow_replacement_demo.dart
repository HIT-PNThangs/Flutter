import 'package:flutter/material.dart';

import '../auto_text_size/auto_size_text.dart';
import 'animated_input.dart';
import 'text_card.dart';
import 'utils.dart';

class OverflowReplacementDemo extends StatelessWidget {
  final bool richText;

  const OverflowReplacementDemo(this.richText, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedInput(
      text: 'This String\'s size will not be smaller than 20. It will be '
          'automatically resized to fit on 4 lines. Otherwise, it will be '
          'replaced by a replacement String! Here is some random stuff, just '
          'to make sure it is long enough.',
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
                        maxLines: 4,
                      )
                    : Text.rich(
                        spanFromString(input),
                        style: const TextStyle(fontSize: 30),
                        maxLines: 4,
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
                        minFontSize: 20,
                        overflowReplacement: const Text(
                          'String cannot be displayed.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        maxLines: 4,
                      )
                    : AutoSizeText.rich(
                        spanFromString(input),
                        style: const TextStyle(fontSize: 30),
                        minFontSize: 20,
                        overflowReplacement: const Text(
                          'String cannot be displayed.',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20,
                          ),
                        ),
                        maxLines: 4,
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
