import 'package:flutter/widgets.dart';

import '../common.dart';
import '../staggered_grid_view/src/layouts/staired.dart';

class StairedPage extends StatelessWidget {
  const StairedPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Staired',
      child: GridView.custom(
        gridDelegate: SliverStairedGridDelegate(
          crossAxisSpacing: 48,
          mainAxisSpacing: 24,
          startCrossAxisDirectionReversed: true,
          pattern: const [
            StairedGridTile(0.5, 1),
            StairedGridTile(0.5, 3 / 4),
            StairedGridTile(1.0, 10 / 4),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Tile(index: index),
        ),
      ),
    );
  }
}
