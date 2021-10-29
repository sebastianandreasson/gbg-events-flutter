import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/widgets/month.dart';
import 'package:provider/provider.dart';
import 'package:gbg_events_flutter/state/calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Month> months = context.watch<CalendarProvider>().months;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ...months.map(
            (m) => MonthWidget(
              month: m,
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<CalendarProvider>().increment(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
