import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../src/utils/modal_scroll_controller.dart';

class ModalWithNavigator extends StatelessWidget {
  const ModalWithNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Navigator(
      onGenerateRoute: (_) => MaterialPageRoute(
        builder: (context2) => Builder(
          builder: (context) => CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(leading: Container(), middle: const Text('Modal Page')),
            child: SafeArea(
              bottom: false,
              child: ListView(
                shrinkWrap: true,
                controller: ModalScrollController.of(context),
                children: ListTile.divideTiles(
                  context: context,
                  tiles: List.generate(
                      100,
                      (index) => ListTile(
                            title: const Text('Item'),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => CupertinoPageScaffold(
                                    navigationBar: const CupertinoNavigationBar(
                                      middle: Text('New Page'),
                                    ),
                                    child: Stack(
                                      fit: StackFit.expand,
                                      children: <Widget>[
                                        MaterialButton(
                                          onPressed: () => Navigator.of(context).pop(),
                                          child: const Text('touch here'),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          )),
                ).toList(),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
