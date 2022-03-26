import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:gbg_events_flutter/screens/event.dart';
import 'package:gbg_events_flutter/screens/home.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:go_router/go_router.dart';
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
  events = await readJson();
  provider.init(events);

  runApp(App(
    provider: provider,
  ));
}

class App extends StatelessWidget {
  final CalendarProvider provider;

  App({Key? key, required this.provider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => provider,
        ),
      ],
      child: MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  late final _router = GoRouter(
    routes: [
      GoRoute(
        name: 'home',
        path: '/',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        name: 'event',
        path: '/event/:id',
        builder: (context, state) {
          final id = state.params['id']!;

          Event? event = provider.getEvent(id);

          return Home(
            event: event != null ? EventPage(event: event) : null,
          );
        },
      ),
      // GoRoute(
      //   path: '/event/:id',
      //   builder: (context, state) => const Event(),
      // ),
    ],
  );
}
