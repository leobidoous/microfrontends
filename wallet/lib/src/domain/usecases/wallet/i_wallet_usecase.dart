import 'package:core/core.dart';

import '../../entities/transaction_entity.dart';

abstract class IWalletUsecase {
  Future<Either<Exception, List<TransactionEntity>>> fetchTransactions({
    PaginationEntity? pagination,
  });
}
