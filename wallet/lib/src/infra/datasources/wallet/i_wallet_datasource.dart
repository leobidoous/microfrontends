import 'package:core/core.dart';

import '../../../domain/entities/transaction_entity.dart';

abstract class IWalletDatasource {
  Future<Either<Exception, List<TransactionEntity>>> fetchTransactions({
    PaginationEntity? pagination,
    required String customerId,
  });
}
