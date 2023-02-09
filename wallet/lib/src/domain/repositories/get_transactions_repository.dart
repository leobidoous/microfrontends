import 'package:core/core.dart';

import '../entities/transaction_entity.dart';

abstract class IGetTransactionsRepository {
  Future<Either<Exception, List<TransactionEntity>>> call();
}