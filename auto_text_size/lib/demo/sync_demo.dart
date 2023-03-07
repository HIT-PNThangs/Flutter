import 'package:flutter/material.dart';

import '../auto_text_size/auto_size_text.dart';
import 'text_card.dart';
import 'utils.dart';

class SyncDemo extends StatefulWidget {
  final bool richText;

  const SyncDemo(this.richText, {super.key});

  @override
  _SyncDemoState createState() => _SyncDemoState();
}

class _SyncDemoState extends State<SyncDemo> with SingleTickerProviderStateMixin {
  double _scale = 0;
  var group = AutoSizeGroup();
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _controller.addListener(() {
      setState(() {
        _scale = _controller.value;
      });
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 3), () {
          _controller.forward(from: 0.1);
        });
      }
    });

    _controller.forward(from: 0.1);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final group = AutoSizeGroup();
    const text = 'These AutoSizeTexts fit the available space and synchronize their '
        'text sizes.';
    return Column(
      children: <Widget>[
        Expanded(
          child: TextCard(
            title: 'AutoSizeText 1',
            child: Visibility(
              visible: !widget.richText,
              replacement: AutoSizeText.rich(
                spanFromString(text),
                group: group,
                style: const TextStyle(fontSize: 40),
                stepGranularity: 0.1,
                maxLines: 4,
              ),
              child: AutoSizeText(
                text,
                group: group,
                style: const TextStyle(fontSize: 40),
                stepGranularity: 0.1,
                maxLines: 3,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: Row(
            children: <Widget>[
              Flexible(
                flex: ((1000 - _scale * 1000) / 2).round(),
                child: Container(),
              ),
              Flexible(
                flex: (_scale * 1000).round(),
                child: TextCard(
                  title: 'AutoSizeText 2',
                  child: Visibility(
                    visible: !widget.richText,
                    replacement: AutoSizeText.rich(
                      spanFromString(text),
                      group: group,
                      style: const TextStyle(fontSize: 40),
                      stepGranularity: 0.1,
                      maxLines: 4,
                    ),
                    child: AutoSizeText(
                      text,
                      group: group,
                      style: const TextStyle(fontSize: 40),
                      stepGranularity: 0.1,
                      maxLines: 3,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: ((1000 - _scale * 1000) / 2).round(),
                child: Container(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
