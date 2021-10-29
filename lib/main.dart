import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/app.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:provider/provider.dart';

void main() {
  var provider = CalendarProvider();
  provider.init();

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
