import 'dart:collection';

import 'package:flutter/material.dart';

import 'visibility_detector/visibility_detector.dart';

const String title = 'VisibilityDetector Demo';

const double cellWidth = 125;
const double cellHeight = 65;

const double externalCellPadding = 5;

const double _cellPadding = 10;

const double _reportPadding = 5;

const double _reportHeight = 200;

const mainListKey = Key('MainList');

const scaleButtonKey = Key('scaleButton');

Key secondaryScrollableKey(int primaryIndex) => ValueKey('secondary-$primaryIndex');

Key cellKey(int row, int col) => Key('Cell-$row-$col');

Key cellContentKey(int row, int col) => Key('Content-$row-$col');

final visibilityListeners = <void Function(RowColumn rc, VisibilityInfo info)>[];

void main() => runApp(const VisibilityDetectorDemo());

class Layout {
  const Layout(this.mainAxis, this.secondaryAxis, {this.reverse = false});

  final Axis mainAxis;
  final Axis secondaryAxis;

  final bool reverse;
}

class VisibilityDetectorDemo extends StatelessWidget {
  const VisibilityDetectorDemo({Key? key, this.useSlivers = false}) : super(key: key);

  final bool useSlivers;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      scrollBehavior: const MaterialScrollBehavior().copyWith(scrollbars: false),
      theme: ThemeData(primarySwatch: Colors.blue),
      home: VisibilityDetectorDemoPage(key: key, useSlivers: useSlivers),
    );
  }
}

class VisibilityDetectorDemoPage extends StatefulWidget {
  const VisibilityDetectorDemoPage({Key? key, this.useSlivers = false}) : super(key: key);

  final bool useSlivers;

  @override
  VisibilityDetectorDemoPageState createState() => VisibilityDetectorDemoPageState();
}

class VisibilityDetectorDemoPageState extends State<VisibilityDetectorDemoPage> {
  VisibilityDetectorDemoPageState();

  var _layoutIndex = 0;

  bool _tableShown = true;

  bool _useSlivers = false;

  bool _useScale = false;

  static const _layouts = [
    Layout(Axis.vertical, Axis.horizontal, reverse: false),
    Layout(Axis.vertical, Axis.horizontal, reverse: true),
    Layout(Axis.horizontal, Axis.vertical, reverse: false),
    Layout(Axis.horizontal, Axis.vertical, reverse: true),
  ];

  Layout get _layout => _layouts[_layoutIndex];

  @override
  void initState() {
    super.initState();
    _useSlivers = widget.useSlivers;
  }

  void _toggleTable() {
    setState(() {
      _tableShown = !_tableShown;
    });
  }

  void _toggleScale() {
    setState(() {
      _useScale = !_useScale;
    });
  }

  void _toggleLayout() {
    setState(() {
      _layoutIndex = (_layoutIndex + 1) % _layouts.length;
    });
  }

  void _toggleSlivers() {
    setState(() {
      _useSlivers = !_useSlivers;
    });
  }

  @override
  Widget build(BuildContext context) {
    final table = !_tableShown
        ? null
        : ClipRect(
            child: SizedBox(
              width: _useScale ? 400 : null,
              height: _useScale ? 300 : null,
              child: ListView.builder(
                key: mainListKey,
                scrollDirection: _layout.mainAxis,
                itemExtent: (_layout.mainAxis == Axis.vertical ? cellHeight : cellWidth) + 2 * externalCellPadding,
                itemBuilder: (BuildContext context, int primaryIndex) {
                  return _useSlivers
                      ? SliverDemoPageSecondaryAxis(
                          key: secondaryScrollableKey(primaryIndex),
                          primaryIndex: primaryIndex,
                          secondaryAxis: _layout.secondaryAxis,
                          reverse: _layout.reverse,
                          useScale: _useScale,
                        )
                      : DemoPageSecondaryAxis(
                          key: secondaryScrollableKey(primaryIndex),
                          primaryIndex: primaryIndex,
                          secondaryAxis: _layout.secondaryAxis,
                          reverse: _layout.reverse,
                          useScale: _useScale,
                        );
                },
              ),
            ),
          );

    return Scaffold(
      appBar: AppBar(title: const Text(title)),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            shape: const Border(),
            onPressed: _toggleLayout,
            heroTag: null,
            child: const Text('Layout'),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            shape: const Border(),
            onPressed: _toggleSlivers,
            heroTag: null,
            child: _useSlivers ? const Text('RenderBox') : const Text('RenderSliver'),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            shape: const Border(),
            onPressed: _toggleTable,
            heroTag: null,
            child: _tableShown ? const Text('Hide') : const Text('Show'),
          ),
          const SizedBox(width: 8),
          FloatingActionButton(
            key: scaleButtonKey,
            shape: const Border(),
            onPressed: _toggleScale,
            heroTag: null,
            child: _useScale ? const Text('Scale') : const Text('No scaling'),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _tableShown ? Expanded(child: table!) : const Spacer(),
          VisibilityReport(title: 'Visibility (${_useSlivers ? "RenderSliver" : "RenderBox"})'),
        ],
      ),
    );
  }
}

class DemoPageSecondaryAxis extends StatelessWidget {
  const DemoPageSecondaryAxis({
    Key? key,
    required this.primaryIndex,
    required this.secondaryAxis,
    required this.reverse,
    required this.useScale,
  }) : super(key: key);

  final Axis secondaryAxis;
  final int primaryIndex;
  final bool reverse;
  final bool useScale;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: secondaryAxis,
      reverse: reverse,
      padding: const EdgeInsets.all(externalCellPadding),
      itemBuilder: (BuildContext context, int secondaryIndex) {
        return DemoPageCell(
          primaryIndex: primaryIndex,
          secondaryIndex: secondaryIndex,
          useSlivers: false,
          useScale: useScale,
        );
      },
    );
  }
}

class SliverDemoPageSecondaryAxis extends StatelessWidget {
  const SliverDemoPageSecondaryAxis({
    Key? key,
    required this.primaryIndex,
    required this.secondaryAxis,
    required this.reverse,
    required this.useScale,
  }) : super(key: key);

  final Axis secondaryAxis;
  final int primaryIndex;
  final bool reverse;
  final bool useScale;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: secondaryAxis == Axis.horizontal
          ? const EdgeInsets.symmetric(vertical: externalCellPadding)
          : const EdgeInsets.symmetric(horizontal: externalCellPadding),
      child: CustomScrollView(
        scrollDirection: secondaryAxis,
        reverse: reverse,
        slivers: [
          const SliverToBoxAdapter(
            child: SizedBox(
              width: externalCellPadding,
              height: externalCellPadding,
            ),
          ),
          // Sliver version renders up to 20 columns.
          for (var secondaryIndex = 0; secondaryIndex < 20; secondaryIndex++)
            DemoPageCell(
              primaryIndex: primaryIndex,
              secondaryIndex: secondaryIndex,
              useSlivers: true,
              useScale: useScale,
            ),
          const SliverToBoxAdapter(
            child: SizedBox(
              width: externalCellPadding,
              height: externalCellPadding,
            ),
          ),
        ],
      ),
    );
  }
}

class DemoPageCell extends StatelessWidget {
  DemoPageCell({
    Key? key,
    required this.primaryIndex,
    required this.secondaryIndex,
    required this.useSlivers,
    required this.useScale,
  })  : _cellName = 'Item $primaryIndex-$secondaryIndex',
        _backgroundColor = ((primaryIndex + secondaryIndex) % 2 == 0) ? Colors.pink[200] : Colors.yellow[200],
        super(key: key);

  final int primaryIndex;
  final int secondaryIndex;
  final bool useSlivers;
  final bool useScale;

  final String _cellName;

  final Color? _backgroundColor;

  void _handleVisibilityChanged(VisibilityInfo info) {
    for (final listener in visibilityListeners) {
      listener(RowColumn(primaryIndex, secondaryIndex), info);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cell = Container(
      key: cellContentKey(primaryIndex, secondaryIndex),
      width: cellWidth,
      decoration: BoxDecoration(color: _backgroundColor),
      padding: const EdgeInsets.all(_cellPadding),
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          _cellName,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );

    if (useSlivers) {
      return SliverVisibilityDetector(
        key: cellKey(primaryIndex, secondaryIndex),
        onVisibilityChanged: _handleVisibilityChanged,
        sliver: SliverToBoxAdapter(child: cell),
      );
    }

    var visibilityDetector = VisibilityDetector(
      key: cellKey(primaryIndex, secondaryIndex),
      onVisibilityChanged: _handleVisibilityChanged,
      child: cell,
    );

    if (useScale) {
      return Transform.scale(
        scale: 0.25,
        child: Padding(
          padding: const EdgeInsets.only(left: 100),
          child: visibilityDetector,
        ),
      );
    } else {
      return visibilityDetector;
    }
  }
}

class VisibilityReport extends StatelessWidget {
  const VisibilityReport({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final headingTextStyle = Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white);

    final heading = Container(
      padding: const EdgeInsets.all(_reportPadding),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(color: Colors.black),
      child: Text(title, style: headingTextStyle),
    );

    final grid = Container(
      padding: const EdgeInsets.all(_reportPadding),
      decoration: BoxDecoration(color: Colors.grey[300]),
      child: const SizedBox(
        height: _reportHeight,
        child: VisibilityReportGrid(),
      ),
    );

    return Column(children: <Widget>[heading, grid]);
  }
}

class VisibilityReportGrid extends StatefulWidget {
  const VisibilityReportGrid({Key? key}) : super(key: key);

  @override
  VisibilityReportGridState createState() => VisibilityReportGridState();
}

class VisibilityReportGridState extends State<VisibilityReportGrid> {
  final _visibilities = SplayTreeMap<RowColumn, double>();

  List<Text>? _reportItems;

  @override
  void initState() {
    super.initState();

    visibilityListeners.add(_update);
    assert(visibilityListeners.contains(_update));
  }

  @override
  void dispose() {
    visibilityListeners.remove(_update);

    super.dispose();
  }

  void _update(RowColumn rc, VisibilityInfo info) {
    setState(() {
      if (info.visibleFraction == 0) {
        _visibilities.remove(rc);
      } else {
        _visibilities[rc] = info.visibleFraction;
      }

      _reportItems = null;
    });
  }

  List<Text> _generateReportItems() {
    final entries = _visibilities.entries;
    final items = <Text>[];

    for (final i in entries) {
      final visiblePercentage = (i.value * 100).toStringAsFixed(1);
      items.add(Text('${i.key}: $visiblePercentage%'));
    }

    final tailIndex = items.length - items.length ~/ 3;
    final midIndex = tailIndex - tailIndex ~/ 2;
    final head = items.getRange(0, midIndex);
    final mid = items.getRange(midIndex, tailIndex);
    final tail = items.getRange(tailIndex, items.length);
    return collate([head, mid, tail]).toList(growable: false);
  }

  @override
  Widget build(BuildContext context) {
    _reportItems ??= _generateReportItems();

    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 8,
      padding: const EdgeInsets.all(5),
      children: _reportItems!,
    );
  }
}

class RowColumn extends Comparable<RowColumn> {
  RowColumn(this.row, this.column);

  final int row;
  final int column;

  @override
  bool operator ==(dynamic other) {
    if (other is RowColumn) {
      return row == other.row && column == other.column;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(row, column);

  @override
  int compareTo(RowColumn other) {
    if (row < other.row) {
      return -1;
    } else if (row > other.row) {
      return 1;
    }

    if (column < other.column) {
      return -1;
    } else if (column > other.column) {
      return 1;
    }

    return 0;
  }

  @override
  String toString() {
    return '[$row, $column]';
  }
}

@visibleForTesting
Iterable<T> collate<T>(Iterable<Iterable<T>> iterables) sync* {
  final iterators = [for (final iterable in iterables) iterable.iterator];
  if (iterators.isEmpty) {
    return;
  }

  while (true) {
    var exhaustedCount = 0;
    for (final i in iterators) {
      if (i.moveNext()) {
        yield i.current;
        continue;
      }

      exhaustedCount += 1;
      if (exhaustedCount == iterators.length) {
        // All iterators are at their ends.
        return;
      }
    }
  }
}
