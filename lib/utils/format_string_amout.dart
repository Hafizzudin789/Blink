import 'package:intl/intl.dart';

String formatStringToAmount(String value) {

  if(value.endsWith(".")) {
    return value;
  }
  var formatter = NumberFormat();
  return formatter.format(double.parse(value));
}