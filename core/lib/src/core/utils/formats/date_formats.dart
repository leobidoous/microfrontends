import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:intl/intl.dart' as df show DateFormat;

class DateFormat {
  static String toDate(DateTime? date, {String pattern = 'dd/MM/yyyy'}) {
    if (date == null) return '';

    return df.DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static DateTime tryParseOrDateNow(String? date) {
    return DateTime.tryParse(date ?? '') ?? DateTime.now();
  }

  static String toTime(DateTime? date, {String pattern = 'HH:mm:ss'}) {
    if (date == null) return '';

    return df.DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static String toDateTime(DateTime? date, {String pattern = 'dd/MM/yyyy HH:mm:ss'}) {
    if (date == null) return '';

    return df.DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static DateTime? fromString(String date, {format = ''}) {
    try {
      return df.DateFormat(format).parse(date);
    } catch (e) {
      return null;
    }
  }

  static bool isSameDate(DateTime date1, DateTime date2) {
    return toDate(date1) == toDate(date2);
  }

  static bool dateIsToday(DateTime date) {
    return toDate(date) == toDate(DateTime.now());
  }

  static DateTime timestampToDate(dynamic date) {
    try {
      if (date == null) return Timestamp.now().toDate();
      return DateTime.parse(date);
    } catch (e) {
      if (date is String) return Timestamp.now().toDate();

      return date?.toDate() ?? Timestamp.now().toDate();
    }
  }
}
