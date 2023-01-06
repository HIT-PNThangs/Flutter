import 'package:flutter/material.dart';

import '../spin_kit/wave.dart';

Widget defaultLoadingWidget = SpinKitWave(
  size: 30,
  color: Colors.grey[350],
  duration: const Duration(milliseconds: 1000),
  itemCount: 7,
);

class DynamicListView extends StatefulWidget {
  const DynamicListView.build({
    Key? key,
    required this.itemBuilder,
    required this.dataRequester,
    required this.initRequester,
    this.initLoadingWidget,
    this.moreLoadingWidget,
  }) : super(key: key);

  final Function itemBuilder;
  final Function dataRequester;
  final Function initRequester;
  final Widget? initLoadingWidget;
  final Widget? moreLoadingWidget;

  @override
  State createState() => DynamicListViewState();
}

class DynamicListViewState extends State<DynamicListView> {
  bool isPerformingRequest = false;
  final ScrollController _controller = ScrollController();
  late List _dataList;

  @override
  void initState() {
    super.initState();
    _onRefresh();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color loadingColor = Theme.of(context).primaryColor;
    return _dataList == null
        ? loadingProgress(
            loadingColor,
            initLoadingWidget: widget.initLoadingWidget,
          )
        : RefreshIndicator(
            displacement: 20,
            color: loadingColor,
            onRefresh: _onRefresh,
            child: ListView.separated(
              separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0, color: Colors.black54),
              itemCount: _dataList.length + 1,
              itemBuilder: (context, index) {
                if (index == _dataList.length) {
                  return opacityLoadingProgress(
                    isPerformingRequest,
                    loadingColor,
                    loadingWidget: widget.moreLoadingWidget,
                  );
                } else {
                  return widget.itemBuilder(_dataList, context, index);
                }
              },
              controller: _controller,
            ),
          );
  }

  Future<void> _onRefresh() async {
    List initDataList = await widget.initRequester();
    setState(() => _dataList = initDataList);
    return;
  }

  _loadMore() async {
    setState(() => isPerformingRequest = true);
    List newDataList = await widget.dataRequester();
    if (newDataList.isEmpty) {
      double edge = 50.0;
      double offsetFromBottom = _controller.position.maxScrollExtent - _controller.position.pixels;
      if (offsetFromBottom < edge) {
        _controller.animateTo(_controller.offset - (edge - offsetFromBottom),
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    } else {
      _dataList.addAll(newDataList);
    }
    setState(() => isPerformingRequest = false);
  }
}

Widget loadingProgress(loadingColor, {Widget? initLoadingWidget}) {
  initLoadingWidget ??= defaultLoadingWidget;

  return Center(
    child: initLoadingWidget,
  );
}

Widget opacityLoadingProgress(isPerformingRequest, loadingColor, {Widget? loadingWidget}) {
  loadingWidget ??= defaultLoadingWidget;

  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Center(
      child: Opacity(
        opacity: isPerformingRequest ? 1.0 : 0.0,
        child: loadingWidget,
      ),
    ),
  );
}
