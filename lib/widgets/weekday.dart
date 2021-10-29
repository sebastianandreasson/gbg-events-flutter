import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/utils/date.dart';

class WeekDay extends StatelessWidget {
  final DateTime date;

  const WeekDay({Key? key, required this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Text(
        dayFormat.format(date).toUpperCase(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
