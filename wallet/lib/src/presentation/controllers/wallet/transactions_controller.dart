import 'package:core/core.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/wallet/i_wallet_usecase.dart';

class FetchTransactionsController
    extends GenController<Exception, List<TransactionEntity>> {
  FetchTransactionsController({required this.usecase}) : super([]);

  final IWalletUsecase usecase;
  PaginationEntity pagination = PaginationEntity();

  Future<void> fetchTransactions({PaginationEntity? pagination}) async {
    await execute(() => usecase.fetchTransactions(pagination: pagination));
  }

  void onResetPagination() {
    pagination = PaginationEntity();
  }
}
