import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/date.dart';
import 'package:gbg_events_flutter/utils/style.dart';
import 'package:gbg_events_flutter/widgets/event_list.dart';
import 'package:gbg_events_flutter/widgets/widget_size.dart';

typedef SizeLayoutCallback = void Function(Size newSize);

class DayWidget extends StatelessWidget {
  final Day day;
  final int index;
  final bool previousMonth;
  final Size largestCellSize;
  final SizeLayoutCallback sizeCallback;

  const DayWidget({
    Key? key,
    required this.day,
    required this.index,
    required this.previousMonth,
    required this.largestCellSize,
    required this.sizeCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = previousMonth
        ? Styling.secondaryTextColor.withOpacity(0.4)
        : isToday(day.date)
            ? Styling.primaryColor
            : Styling.secondaryTextColor;

    return WidgetSize(
      onChange: (Size s) {
        if (s.height > largestCellSize.height) {
          sizeCallback(s);
        }
      },
      child: Container(
        constraints: BoxConstraints(
          minHeight: largestCellSize.height > 0 ? largestCellSize.height : 175,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 1,
              child: Container(
                color: color,
              ),
            ),
            Styling.defaultSpacer,
            Text(
              dateFormat.format(day.date),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            EventList(events: day.events),
          ],
        ),
      ),
    );
  }
}
