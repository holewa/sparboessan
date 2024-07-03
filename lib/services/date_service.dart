import 'package:intl/intl.dart';

class DateService {
   String getDayOfTheWeek(DateTime dateTime) {
    final DateFormat dateFormat = DateFormat('EEEE', 'sv_SE');
    return dayToUpperString(dateFormat.format(dateTime));
  }

  static String dayToUpperString(String day) {
    return day.substring(0, 1).toUpperCase() + day.substring(1);
  }
}
