import 'amount_range.dart';
import 'value_date.dart';

class TransactionsFilterParams {

  final AmountRange amountRange;
  final List<String> category;
  final ValueDate valueDate;
  
  TransactionsFilterParams({
    required this.amountRange,
    required this.category,
    required this.valueDate,
  });


}
