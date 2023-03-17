import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../common.dart';
import '../staggered_grid_view/flutter_staggered_grid_view.dart';

class MasonryPage extends StatelessWidget {
  const MasonryPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Masonry',
      child: MasonryGridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          return Tile(
            index: index,
            extent: (index % 5 + 1) * 100,
          );
        },
      ),
    );
  }
}
