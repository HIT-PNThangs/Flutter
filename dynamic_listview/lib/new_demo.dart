import 'package:flutter/material.dart';

import 'custom_loading.dart';
import 'src/dynamic_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DynamicListController _dynamicListController = DynamicListController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey[200],
          leading: const Icon(Icons.accessibility, color: Colors.cyan),
          title: const Text('Dynamic list', style: TextStyle(color: Colors.black)),
        ),
        body: DynamicList.separated(
          controller: _dynamicListController,
          itemBuilder: _itemBuilder,
          dataRequester: _dataRequester,
          initRequester: _initRequester,
          initLoadingWidget: const CustomLoading(),
          separatorBuilder: (BuildContext context, int index) => const Divider(height: 1.0, color: Colors.black54),
        ),
        persistentFooterButtons: <Widget>[
          MaterialButton(onPressed: () => _dynamicListController.fireRefresh(), child: const Icon(Icons.refresh)),
          MaterialButton(onPressed: () => _dynamicListController.toTop(), child: const Icon(Icons.vertical_align_top))
        ],
      ),
    );
  }

  Future<List> _initRequester() async {
    return Future.value(List.generate(15, (i) => i));
  }

  Future<List> _dataRequester() async {
    return Future.delayed(const Duration(seconds: 2), () {
      return List.generate(10, (i) => 15 + i);
    });
  }

  final Function _itemBuilder = (List dataList, BuildContext context, int index) {
    String title = dataList[index].toString();
    return ListTile(title: Text("Number $title"));
  };
}
