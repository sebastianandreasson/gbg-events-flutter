import 'package:flutter/material.dart';
import 'package:gbg_events_flutter/utils/style.dart';
import 'package:gbg_events_flutter/widgets/filter.dart';
import 'package:gbg_events_flutter/widgets/month.dart';
import 'package:provider/provider.dart';
import 'package:gbg_events_flutter/state/calendar.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Month> months = context.watch<CalendarProvider>().filteredMonths;
    // context.watch<CalendarProvider>().venuesFilter;
    print('redraw');

    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              ...months.map(
                (m) => MonthWidget(
                  month: m,
                ),
              )
            ],
          ),
          const Filter(),
        ],
      ),
    );
  }
}
