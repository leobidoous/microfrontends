import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class FormatNumber {
  static String toCurrency(dynamic value) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format;
    try {
      return format(value);
    } catch (e) {
      return format(0.0);
    }
  }
}

class FormatDate {
  static String toDate(DateTime? date, {String pattern = 'dd/MM/yyyy'}) {
    if (date == null) return '';

    return DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static String toTime(DateTime? date, {String pattern = 'HH:mm:ss'}) {
    if (date == null) return '';

    return DateFormat(pattern, 'pt_BR').format(date.toLocal());
  }

  static String toDateTime(DateTime? date) {
    if (date == null) return '';

    return DateFormat('dd/MM/yyyy HH:mm:ss', 'pt_BR').format(date.toLocal());
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
