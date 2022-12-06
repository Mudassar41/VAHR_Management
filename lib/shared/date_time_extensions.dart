import 'package:intl/intl.dart';

extension Datextensions on DateTime {
  String showDate(String pattern) {
    return DateFormat(pattern).format(this);
  }
}
