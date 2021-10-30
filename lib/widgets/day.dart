import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/date.dart';
import 'package:gbg_events_flutter/widgets/widget_size.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.artist,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Text(event.venue),
          const SizedBox(height: 10),
          Text(timeFormat.format(event.date)),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

typedef void SizeLayoutCallback(Size newSize);

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
        ? Colors.black26
        : isToday(day.date)
            ? Colors.red
            : Colors.black;

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
            const SizedBox(height: 10),
            Text(
              dateFormat.format(day.date),
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            ...day.events.map((e) => EventWidget(event: e)),
          ],
        ),
      ),
    );
  }
}
