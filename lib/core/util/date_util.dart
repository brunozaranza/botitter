import 'package:date_format/date_format.dart';

class DateUtil {
  static String current(){
    DateTime now = DateTime.now();
    return formatDate(now, [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn, ':', ss,
      '.', SSS, z]);
  }

  static String parseDateToString(DateTime date) {
    return formatDate(
        date, [yyyy, '-', mm, '-', dd, 'T', HH, ':', nn, ':', ss,
      '.', SSS, z]);
  }
}