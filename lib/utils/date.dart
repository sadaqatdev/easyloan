import 'package:date_format/date_format.dart';

class DateUtil {
  static String format(int timeSamp) {
    var dateTime = DateTime.fromMillisecondsSinceEpoch(timeSamp);
    return formatDate(
        dateTime, ["yyyy", "-", "mm", "-", "dd", " ", "hh", ":", "mm",":", "ss"]);
  }

  static String formatDateTime(DateTime dateTime) {
    return formatDate(
        dateTime, ["dd", "-", "mm", "-", "yyyy"]);
  }

  static DateTime toDateTime(String formattedString) {
    return DateTime.parse(formattedString);
  }

}
