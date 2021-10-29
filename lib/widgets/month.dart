import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/date.dart';
import 'package:gbg_events_flutter/widgets/day.dart';
import 'package:gbg_events_flutter/widgets/weekday.dart';
import 'package:sliver_tools/sliver_tools.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
      {required this.collapsedHeight,
      required this.expandedHeight,
      required this.date});

  final double expandedHeight;
  final double collapsedHeight;
  final DateTime date;

  @override
  double get minExtent => collapsedHeight;
  @override
  double get maxExtent => math.max(expandedHeight, minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double basePadding = MediaQuery.of(context).size.width * 0.1;
    double padding = math.max(basePadding - shrinkOffset, basePadding / 2.5);
    if (shrinkOffset > 10) {
      return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                Text(
                  monthFormatShort.format(date).toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 1,
                  width: 50,
                  child: Container(
                    color: Colors.black,
                  ),
                ),
                Text(
                  yearFormat.format(date).toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: padding,
      ),
      child: Row(
        children: [
          Text(
            monthFormat.format(date).toUpperCase(),
            style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            yearFormat.format(date),
            style: const TextStyle(
              fontFamily: 'Cormorant',
              fontSize: 34,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return expandedHeight != oldDelegate.expandedHeight ||
        collapsedHeight != oldDelegate.collapsedHeight;
  }
}

class MonthHeader extends StatelessWidget {
  final Month month;

  const MonthHeader({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        date: month.date,
        collapsedHeight: 50,
        expandedHeight: 800,
      ),
    );
  }
}

class MonthWidget extends StatelessWidget {
  final Month month;

  const MonthWidget({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverStack(
      children: [
        MonthHeader(month: month),
        MultiSliver(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 120,
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
              child: StaggeredGridView.count(
                crossAxisCount: 7,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                staggeredTiles: [
                  ...List.generate(7, (_) => const StaggeredTile.fit(1)),
                  ...month.days.map((_) => const StaggeredTile.fit(1))
                ],
                children: [
                  ...List.generate(
                    7,
                    (index) => WeekDay(
                      date: month.start.add(Duration(days: index)),
                    ),
                  ),
                  ...month.days.map(
                    (d) => DayWidget(
                      day: d,
                      previousMonth: !isSameMonth(month.date, d.date),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
