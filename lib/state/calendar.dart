import 'package:flutter/material.dart';

DateTime mostRecentMonday(DateTime date) =>
    DateTime(date.year, date.month, date.day - (date.weekday - 1));

class Day {
  late DateTime date;

  Day(DateTime _date) {
    date = _date;
  }
}

class Month {
  late DateTime start;
  late DateTime date;
  List<Day> days = [];

  Month(DateTime _date) {
    date = _date;
    start = mostRecentMonday(_date);

    DateTime end = DateTime(_date.year, _date.month + 1);
    int daysInMonth = end.difference(start).inDays;
    for (var i = 0; i < daysInMonth; i++) {
      days.add(Day(start.add(Duration(days: i))));
    }
  }
}

class CalendarProvider with ChangeNotifier {
  int counter = 0;
  List<Month> months = [];
  List<DateTime> dates = [];

  void init() {
    DateTime now = DateTime.now();
    DateTime from = DateTime(now.year, now.month, 1);
    // DateTime to = DateTime.now().add(const Duration(days: 365));

    // int days = to.difference(DateTime.now()).inDays;
    for (var i = 0; i < 12; i++) {
      DateTime date = DateTime(from.year, from.month + i);
      months.add(Month(date));
      // dates.add(from.add(Duration(days: i)));
    }
  }

  void increment() {
    counter++;
    notifyListeners();
  }
}
