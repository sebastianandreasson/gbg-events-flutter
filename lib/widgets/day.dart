import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/date.dart';

class DayWidget extends StatelessWidget {
  final Day day;
  final bool previousMonth;

  const DayWidget({Key? key, required this.day, required this.previousMonth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color = previousMonth
        ? Colors.black26
        : isToday(day.date)
            ? Colors.red
            : Colors.black;

    return SizedBox(
      height: 150,
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
        ],
      ),
    );
  }
}
