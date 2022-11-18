import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/bottom_sheets/cupertino_bottom_sheet.dart';
import '../src/utils/modal_scroll_controller.dart';

class ModalInsideModal extends StatelessWidget {
  final bool reverse;

  const ModalInsideModal({Key? key, this.reverse = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          leading: Container(), middle: const Text('Modal Page')),
      child: SafeArea(
        bottom: false,
        child: ListView(
          reverse: reverse,
          shrinkWrap: true,
          controller: ModalScrollController.of(context),
          physics: const ClampingScrollPhysics(),
          children: ListTile.divideTiles(
              context: context,
              tiles: List.generate(
                100,
                (index) => ListTile(
                    title: Text('Item $index'),
                    onTap: () => showCupertinoModalBottomSheet(
                          expand: true,
                          isDismissible: false,
                          context: context,
                          backgroundColor: Colors.transparent,
                          builder: (context) =>
                              ModalInsideModal(reverse: reverse),
                        )),
              )).toList(),
        ),
      ),
    ));
  }
}
