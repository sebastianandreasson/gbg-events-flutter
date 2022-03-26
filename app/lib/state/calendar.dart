import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/utils/date.dart';
import 'package:uuid/uuid.dart';

class Event {
  late String id;
  late String artist;
  late String venue;
  late DateTime date;

  Event(Map<String, dynamic> json) {
    id = Uuid().v4();
    venue = json['venue'];
    artist = json['artist'];
    date = DateTime.parse(json['date']);
  }
}

class Day {
  late DateTime date;
  late List<Event> events = [];

  Day(DateTime _date, List<Event> allEvents) {
    date = _date;
    allEvents.forEach((event) {
      DateTime eventDay =
          DateTime(event.date.year, event.date.month, event.date.day);
      if (date == eventDay) {
        events.add(event);
      }
    });
    events.sort((a, b) => a.date.difference(b.date).inSeconds);
  }
}

class Month {
  late DateTime start;
  late DateTime date;
  List<Day> days = [];

  Month(DateTime _date, List<Event> events) {
    date = _date;
    start = mostRecentMonday(_date);

    DateTime end = DateTime(_date.year, _date.month + 1);
    int daysInMonth = end.difference(start).inDays;
    for (var i = 0; i < daysInMonth; i++) {
      Day day = Day(start.add(Duration(days: i)), events);
      days.add(day);
    }
  }
}

class CalendarProvider with ChangeNotifier {
  int counter = 0;
  List<Event> events = [];
  List<Month> months = [];
  List<DateTime> dates = [];
  List<String> venuesFilter = [];

  List<Month> get filteredMonths {
    List<Event> filteredEvents = events.where((event) {
      if (venuesFilter.isEmpty) return true;
      return venuesFilter.contains(event.venue);
    }).toList();

    return months.map((month) {
      return Month(month.date, filteredEvents);
    }).toList();
  }

  List<String> get venues {
    return events.map((e) => e.venue).toSet().toList();
  }

  void init(List<Event> _events) {
    events = _events;
    DateTime now = DateTime.now();
    DateTime from = DateTime(now.year, now.month, 1);
    for (var i = 0; i < 12; i++) {
      DateTime date = DateTime(from.year, from.month + i);
      try {
        months.add(Month(date, events));
      } catch (e) {
        print(e);
      }
    }
  }

  void setVenuesFilter(List<String> venues) {
    venuesFilter = venues;
    notifyListeners();
  }

  Event? getEvent(String id) {
    return events.firstWhere((e) => e.id == id);
  }
}
