import 'package:intl/intl.dart';

String formatStringToAmount(String value) {

  var formatter = NumberFormat();
  return formatter.format(double.tryParse(value));
}