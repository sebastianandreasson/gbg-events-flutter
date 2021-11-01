import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/widgets/month.dart';
import 'package:provider/provider.dart';
import 'package:gbg_events_flutter/state/calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Month> months = context.watch<CalendarProvider>().filteredMonths;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 56),
        child: CustomScrollView(
          slivers: [
            ...months.map(
              (m) => MonthWidget(
                month: m,
              ),
            )
          ],
        ),
      ),
    );
  }
}
