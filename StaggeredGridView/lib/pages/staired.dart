import 'package:flutter/widgets.dart';

import '../common.dart';
import '../staggered_grid_view/src/layouts/staired.dart';

class StairedPage extends StatelessWidget {
  const StairedPage({
    Key? key,
  }) : super(key: key);

  static const pattern = [
    StairedGridTile(0.5, 1),
    StairedGridTile(0.5, 3 / 4),
    StairedGridTile(1.0, 10 / 4),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Staired',
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: GridView.custom(
          scrollDirection: Axis.vertical,
          gridDelegate: SliverStairedGridDelegate(
            mainAxisSpacing: 24,
            crossAxisSpacing: 48,
            startCrossAxisDirectionReversed: true,
            pattern: pattern,
          ),
          childrenDelegate: SliverChildBuilderDelegate(
            (context, index) {
              final tile = pattern[index % pattern.length];
              return ImageTile(
                index: index,
                width: (tile.aspectRatio * 200).ceil(),
                height: 200,
              );
            },
          ),
        ),
      ),
    );
  }
}
