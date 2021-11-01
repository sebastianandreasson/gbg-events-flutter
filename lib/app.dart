import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/screens/home.dart';
import 'package:gbg_events_flutter/utils/style.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Styling.primarySwatch,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Styling.backgroundColor,
      ),
      home: const Home(),
    );
  }
}
