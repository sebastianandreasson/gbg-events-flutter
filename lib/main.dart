import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gbg_events_flutter/app.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:provider/provider.dart';

Future<List<Event>> readJson() async {
  String response = await rootBundle.loadString(
    'assets/events.json',
  );
  Map<String, dynamic> data = await json.decode(response);
  List<Event> events = [];

  data['items'].forEach((e) {
    Event event = Event(e);
    events.add(event);
  });

  return events;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var provider = CalendarProvider();
  List<Event> events = [];
  try {
    events = await readJson();
  } catch (e) {}
  provider.init(events);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => provider,
        ),
      ],
      child: const App(),
    ),
  );
}
