import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gbg_events_flutter/state/calendar.dart';
import 'package:gbg_events_flutter/utils/style.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

typedef OnTap = void Function();

class FilterContent extends StatelessWidget {
  final bool active;
  final OnTap onTap;

  const FilterContent({Key? key, required this.active, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> venues = context.watch<CalendarProvider>().venues;

    Widget content;
    if (!active) {
      content = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              InkWell(
                onTap: onTap,
                child: const Icon(Icons.tune, color: Colors.white),
              ),
            ],
          )
        ],
      );
    } else {
      content = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MultiSelectDialogField(
                title: const Text(
                  'Venue',
                  style: TextStyle(
                    color: Styling.primaryTextColor,
                  ),
                ),
                buttonText: const Text(
                  'Venue',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                buttonIcon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.white,
                ),
                searchHint: 'Select venue',
                items:
                    venues.map((name) => MultiSelectItem(name, name)).toList(),
                onConfirm: (items) {},
              ),
              InkWell(
                onTap: onTap,
                child: const Icon(Icons.close, color: Colors.white),
              ),
            ],
          )
        ],
      );
    }

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
        height: active ? 300 : 24,
        width: active ? 300 : 24,
        child: content,
      ),
    );
  }
}

class Filter extends HookWidget {
  const Filter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> active = useState(false);
    double size = active.value ? 600 : 60;
    double top = active.value ? 128 : 0;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOutCubic,
      top: 134 - top,
      right: 64 - top,
      child: ClipOval(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.bounceOut,
          color: Styling.primaryColor,
          width: size,
          height: size,
          padding: const EdgeInsets.all(Styling.defaultSpacing),
          child: FilterContent(
              active: active.value,
              onTap: () {
                active.value = !active.value;
              }),
        ),
      ),
    );
  }
}
