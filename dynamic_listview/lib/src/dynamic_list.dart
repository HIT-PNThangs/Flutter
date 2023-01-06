import 'package:flutter/material.dart';

import '../custom_loading.dart';
import '../spin_kit/wave.dart';

Widget defaultLoadingWidget = SpinKitWave(
  size: 30,
  color: Colors.grey[350],
  duration: const Duration(milliseconds: 1000),
  itemCount: 7,
);

class DynamicList extends StatefulWidget {
  DynamicList.build({
    Key? key,
    required this.itemBuilder,
    required this.dataRequester,
    required this.initRequester,
    this.initLoadingWidget,
    this.moreLoadingWidget,
    this.controller,
    this.scrollDirection = Axis.vertical,
  })  : separated = false,
        super(key: key);

  DynamicList.separated({
    Key? key,
    required this.itemBuilder,
    required this.dataRequester,
    required this.initRequester,
    this.initLoadingWidget,
    this.moreLoadingWidget,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.separatorBuilder,
  })  : separated = true,
        super(key: key);

  final Function itemBuilder;
  final Function dataRequester;
  final Function initRequester;
  final Widget? initLoadingWidget;
  final Widget? moreLoadingWidget;
  final bool separated;
  final DynamicListController? controller;
  final Axis scrollDirection;
  IndexedWidgetBuilder? separatorBuilder =
      (BuildContext context, int index) => Divider(height: 1.0, color: Theme.of(context).hintColor);

  @override
  State createState() => DynamicListState();
}

class DynamicListState extends State<DynamicList> {
  bool _isPerformingRequest = false;
  final ScrollController _scrollController = ScrollController();
  late List _dataList = [];

  @override
  void initState() {
    super.initState();
    _onRefresh();
    if (widget.controller != null) {
      widget.controller!.refresh = () => _onRefresh();
      widget.controller!.scrollController = _scrollController;
    }
    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color loadingColor = Theme.of(context).primaryColor;

    return _dataList == null
        ? loadingProgress(
            loadingColor,
            initLoadingWidget: widget.initLoadingWidget ?? const CustomLoading(),
          )
        : RefreshIndicator(
            displacement: 20,
            color: loadingColor,
            onRefresh: _onRefresh,
            child: widget.separated
                ? ListView.separated(
                    scrollDirection: widget.scrollDirection,
                    separatorBuilder: widget.separatorBuilder!,
                    itemCount: _dataList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _dataList.length) {
                        return opacityLoadingProgress(
                          _isPerformingRequest,
                          loadingColor,
                          loadingWidget: widget.moreLoadingWidget ?? const CustomLoading(),
                        );
                      } else {
                        return widget.itemBuilder(_dataList, context, index);
                      }
                    },
                    controller: _scrollController,
                  )
                : ListView.builder(
                    scrollDirection: widget.scrollDirection,
                    itemCount: _dataList.length + 1,
                    itemBuilder: (context, index) {
                      if (index == _dataList.length) {
                        return opacityLoadingProgress(
                          _isPerformingRequest,
                          loadingColor,
                          loadingWidget: widget.moreLoadingWidget!,
                        );
                      } else {
                        return widget.itemBuilder(_dataList, context, index);
                      }
                    },
                    controller: _scrollController,
                  ),
          );
  }

  Future<void> _onRefresh() async {
    List initDataList = await widget.initRequester();
    if (mounted) setState(() => _dataList = initDataList);
    return;
  }

  _loadMore() async {
    if (mounted) setState(() => _isPerformingRequest = true);
    List newDataList = await widget.dataRequester();
    if (newDataList.isEmpty) {
      double edge = 50.0;
      double offsetFromBottom = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;
      if (offsetFromBottom < edge) {
        _scrollController.animateTo(_scrollController.offset - (edge - offsetFromBottom),
            duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    } else {
      _dataList.addAll(newDataList);
    }
    if (mounted) setState(() => _isPerformingRequest = false);
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

class DynamicListController {
  late Function refresh;
  late ScrollController scrollController;

  fireRefresh() {
    refresh();
    toTop();
  }

  toTop() {
    if (scrollController.hasClients) {
      scrollController.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
    }
  }
}
