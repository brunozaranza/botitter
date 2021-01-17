import 'package:date_format/date_format.dart';
import 'package:timeago/timeago.dart' as timeAgo;


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

  static String textTimeAgo(String fromDate) {
    DateTime date = DateTime.parse(fromDate);

    timeAgo.setLocaleMessages('pt_BR', timeAgo.PtBrMessages());

    return timeAgo.format(date, locale: "pt_BR", allowFromNow: true);
  }

}