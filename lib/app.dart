import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/screens/home.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Montserrat',
        scaffoldBackgroundColor: Color.fromARGB(255, 248, 241, 224),
      ),
      home: const Home(),
    );
  }
}
