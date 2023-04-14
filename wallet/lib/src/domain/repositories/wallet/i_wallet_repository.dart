import 'package:core/core.dart';

import '../../entities/transaction_entity.dart';

abstract class IWalletRepository {
  Future<Either<Exception, List<TransactionEntity>>> fetchTransactions({
    PaginationEntity? pagination,
    required String customerId,
  });
}
