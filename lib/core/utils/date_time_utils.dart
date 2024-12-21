part of 'utils.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static Duration getDuration(num? seconds) {
    return Duration(seconds: seconds?.toInt() ?? 0);
  }

  static String? timeleft(DateTime due) {
    String? value;

    Duration timeUntilDue = due.difference(DateTime.now());

    int daysUntil = timeUntilDue.inDays;
    int hoursUntil = timeUntilDue.inHours - (daysUntil * 24);
    int minUntil =
        timeUntilDue.inMinutes - (daysUntil * 24 * 60) - (hoursUntil * 60);
    int secUntil = timeUntilDue.inSeconds -
        (daysUntil * 24 * 60 * 60) -
        (hoursUntil * 60 * 60) -
        (minUntil * 60);

    if (daysUntil > 0) {
      value = '${daysUntil.toString().padLeft(2, '0')} Days Away';
    } else if (hoursUntil > 0) {
      value = '${hoursUntil.toString().padLeft(2, '0')} Hours Away';
    } else if (minUntil > 0) {
      value = '${minUntil.toString().padLeft(2, '0')} Minutes Away';
    } else if (secUntil > 0) {
      value = '${secUntil.toString().padLeft(2, '0')} Seconds Away';
    }

    return value;
  }
}
