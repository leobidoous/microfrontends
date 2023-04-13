import 'package:intl/intl.dart' as nf show NumberFormat;

class NumberFormat {
  static String toCurrency(dynamic value, {String? symbol = 'R\$'}) {
    final format = nf.NumberFormat.currency(
      locale: 'pt_BR',
      symbol: symbol,
    ).format;
    try {
      return format(double.tryParse(value.toString())).trim();
    } catch (e) {
      return format(0.0);
    }
  }
}
