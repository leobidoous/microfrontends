import 'package:intl/intl.dart';

class Number {
  static String toCurrency(dynamic value) {
    final format = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format;
    try {
      return format(value);
    } catch (e) {
      return format(0.0);
    }
  }
}
