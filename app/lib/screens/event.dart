import 'package:flutter/widgets.dart';
import 'package:gbg_events_flutter/state/calendar.dart';

class EventPage extends StatelessWidget {
  final Event event;

  const EventPage({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 500,
      child: Center(child: Text(event.artist)),
    );
  }
}
