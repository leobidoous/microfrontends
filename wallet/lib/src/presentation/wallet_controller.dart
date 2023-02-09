import 'package:core/core.dart';

import '../domain/entities/transaction_entity.dart';
import '../domain/usecases/get_transactions_usecase.dart';

class WalletController
    extends DefaultController<Exception, List<TransactionEntity>> {
  final IGetTransactionsUsecase usecase;
  WalletController({required this.usecase}) : super([]);

  Future<void> getTransactions() async {
    execute(() => usecase());
  }
}
