import 'package:flutter/material.dart';

import '../auto_text_size/auto_size_text.dart';
import 'animated_input.dart';
import 'text_card.dart';
import 'utils.dart';

class PresetFontSizesDemo extends StatelessWidget {
  final bool richText;

  const PresetFontSizesDemo(this.richText, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedInput(
      text: 'This String has only three allowed sizes: 40, 20 and 14. It will '
          'be automatically resized to fit on 4 lines. With this setting, you '
          'have the most control.',
      builder: (input) {
        return Row(
          children: <Widget>[
            Expanded(
              child: TextCard(
                title: 'Text',
                child: !richText
                    ? Text(
                        input,
                        style: const TextStyle(fontSize: 40),
                        maxLines: 4,
                      )
                    : Text.rich(
                        spanFromString(input),
                        style: const TextStyle(fontSize: 40),
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
                        presetFontSizes: const [40, 20, 14],
                        maxLines: 4,
                      )
                    : AutoSizeText.rich(
                        spanFromString(input),
                        presetFontSizes: const [40, 20, 14],
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
