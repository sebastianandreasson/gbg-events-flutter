import 'dart:math' as math;

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/date.dart';
import 'package:gbg_events_flutter/utils/layout.dart';
import 'package:gbg_events_flutter/utils/style.dart';
import 'package:gbg_events_flutter/widgets/day.dart';
import 'package:gbg_events_flutter/widgets/weekday.dart';
import 'package:gbg_events_flutter/widgets/widget_size.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:waterfall_flow/waterfall_flow.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(
      {required this.collapsedHeight,
      required this.expandedHeight,
      required this.topPadding,
      required this.date});

  final double expandedHeight;
  final double collapsedHeight;
  final double topPadding;
  final DateTime date;

  @override
  double get minExtent => collapsedHeight;
  @override
  double get maxExtent => math.max(expandedHeight, minExtent);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    bool singleColumn = isSingleColumn(context);

    double basePadding = MediaQuery.of(context).size.width * 0.1;
    double padding = math.max(
        basePadding - (shrinkOffset * 2), singleColumn ? 0 : basePadding / 2.5);
    double top = math.min(math.pow(shrinkOffset, 4) / 500000, topPadding);

    if (shrinkOffset > 10) {
      return Padding(
        padding: EdgeInsets.only(left: padding, top: top),
        child: Align(
          alignment: Alignment.topLeft,
          child: SizedBox(
            width: 100,
            child: Column(
              children: [
                AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      monthFormatShort.format(date).toUpperCase(),
                      textStyle: Styling.headingStyle,
                    )
                  ],
                  isRepeatingAnimation: false,
                ),
                SizedBox(
                  height: 1,
                  width: 50,
                  child: Container(
                    color: Styling.primaryTextColor,
                  ),
                ),
                Text(
                  yearFormat.format(date).toUpperCase(),
                  style: const TextStyle(
                    fontFamily: 'Cormorant',
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                    color: Styling.primaryTextColor,
                    height: 0.8,
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
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                monthFormat.format(date).toUpperCase(),
                textStyle: Styling.headingStyle,
                curve: Curves.easeOut,
              )
            ],
            isRepeatingAnimation: false,
          ),
          Padding(
            padding: const EdgeInsets.only(left: Styling.defaultSpacing),
            child: Text(
              yearFormat.format(date),
              style: Styling.headingStyle,
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
  final Size gridSize;
  final double height = 80;
  final double topPadding = 24;

  const MonthHeader({Key? key, required this.month, required this.gridSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      delegate: _SliverAppBarDelegate(
        date: month.date,
        collapsedHeight: height + topPadding,
        expandedHeight: gridSize.height + 80,
        topPadding: topPadding,
      ),
    );
  }
}

class MonthWidget extends HookWidget {
  final Month month;

  const MonthWidget({Key? key, required this.month}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = useState(const Size(0, 0));
    final largestCellSizes = useState(const [
      Size(0, 0),
      Size(0, 0),
      Size(0, 0),
      Size(0, 0),
      Size(0, 0),
      Size(0, 0)
    ]);
    bool singleColumn = isSingleColumn(context);
    double basePadding = MediaQuery.of(context).size.width * 0.1;

    return SliverPadding(
      padding: const EdgeInsets.only(top: Styling.largeSpacing),
      sliver: SliverStack(
        children: [
          MonthHeader(
            month: month,
            gridSize: size.value,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(
                top: Styling.largeSpacing + 44,
                left: singleColumn ? basePadding * 2 : basePadding,
                right: singleColumn ? 25 : basePadding,
              ),
              child: WidgetSize(
                onChange: (Size s) {
                  size.value = s;
                },
                child: WaterfallFlow.builder(
                  cacheExtent: 0.0,
                  shrinkWrap: true,
                  gridDelegate:
                      const SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          crossAxisSpacing: Styling.defaultSpacing * 3,
                          mainAxisSpacing: Styling.defaultSpacing),
                  itemCount: month.days.length + 7,
                  itemBuilder: (BuildContext ctx, int index) {
                    if (index < 7) {
                      return WeekDay(
                        date: month.start.add(Duration(days: index)),
                      );
                    }
                    int i = index - 7;
                    return DayWidget(
                      day: month.days[i],
                      index: i,
                      previousMonth:
                          !isSameMonth(month.date, month.days[i].date),
                      largestCellSize: largestCellSizes.value[(i / 7).floor()],
                      sizeCallback: (Size newSize) {
                        Size oldSize = largestCellSizes.value[(i / 7).floor()];
                        if (newSize.height > oldSize.height) {
                          largestCellSizes.value = [...largestCellSizes.value]
                            ..[(i / 7).floor()] = newSize;
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
