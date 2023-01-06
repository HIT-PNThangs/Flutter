import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../src/modal_bottom_sheet/bottom_sheets/cupertino_bottom_sheet.dart';
import 'cupertino_sheet.dart';

class ModalBottomSheetExample extends StatefulWidget {
  const ModalBottomSheetExample({super.key});

  @override
  State<StatefulWidget> createState() => _ModalBottomSheetExampleState();
}

class _ModalBottomSheetExampleState extends State<ModalBottomSheetExample> {
  @override
  void initState() {
    showModal();
    super.initState();
  }

  showModal() {
    if (!mounted) return;
    Future.delayed(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      showCupertinoModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context, scrollController) => Close(
          child: PhotoShareBottomSheet(scrollController: scrollController),
        ),
      );
    });
    // Future.delayed(Duration(seconds: 9), () => showModal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context),
        body: CupertinoPageScaffold(
          child: Center(
              child: Image.asset(
            'assets/demo_image.jpeg',
          )),
        ),
        bottomNavigationBar: bottomAppBar(context));
  }

  PreferredSizeWidget appBar(BuildContext context) {
    return CupertinoNavigationBar(
      middle: Column(
        children: const <Widget>[
          Text('New York', style: TextStyle(fontWeight: FontWeight.normal)),
          Text('1 February 11:45', style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12))
        ],
      ),
      trailing: Text(
        'Edit',
        style: TextStyle(
          color: CupertinoTheme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget bottomAppBar(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
            child: const Icon(
              CupertinoIcons.share,
              size: 28,
            ),
            onPressed: () {
              showCupertinoModalBottomSheet(
                expand: true,
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context, scrollController) => PhotoShareBottomSheet(scrollController: scrollController),
              );
            },
          ),
          const CupertinoButton(
            onPressed: null,
            child: Icon(CupertinoIcons.heart, size: 28),
          ),
          const CupertinoButton(
            onPressed: null,
            child: Icon(CupertinoIcons.delete, size: 28),
          )
        ],
      ),
    );
  }
}

class Close extends StatefulWidget {
  final Widget child;

  const Close({Key? key, required this.child}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CloseState();
}

class CloseState extends State<Close> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Navigator.of(context).pop();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
