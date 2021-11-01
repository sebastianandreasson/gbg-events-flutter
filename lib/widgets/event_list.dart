import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/date.dart';
import 'package:gbg_events_flutter/utils/style.dart';

class EventWidget extends StatelessWidget {
  final Event event;

  const EventWidget({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Styling.defaultSpacing),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            event.artist,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          Styling.defaultSpacer,
          Text(
            event.venue,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Styling.primaryTextColor,
            ),
          ),
          Styling.defaultSpacer,
          Text(
            timeFormat.format(event.date),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Styling.primaryTextColor,
            ),
          ),
          const SizedBox(height: Styling.defaultSpacing * 2),
        ],
      ),
    );
  }
}

class EventList extends StatelessWidget {
  final List<Event> events;

  const EventList({Key? key, required this.events}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxHeight: 250),
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.purple,
              Colors.transparent,
              Colors.transparent,
              Colors.purple
            ],
            stops: [0.0, 0.05, 0.85, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstOut,
        child: ListView(
          shrinkWrap: true,
          children: events
              .map(
                (e) => EventWidget(
                  event: e,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
