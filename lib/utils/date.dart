import 'package:intl/intl.dart';

var monthFormat = DateFormat('MMMM');
var monthFormatShort = DateFormat('MMM');
var yearFormat = DateFormat('yyyy');
var dateFormat = DateFormat('dd');
var dayFormat = DateFormat('E');
var timeFormat = DateFormat('hh:mm');

DateTime mostRecentMonday(DateTime date) =>
    DateTime(date.year, date.month, date.day - (date.weekday - 1));

bool isToday(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final compare = DateTime(date.year, date.month, date.day);
  return today == compare;
}

bool isSameMonth(DateTime month, DateTime date) {
  final monthCompare = DateTime(month.year, month.month, 0);
  final compare = DateTime(date.year, date.month, 0);
  return monthCompare == compare;
}
