import 'package:core/core.dart';

import '../../domain/entities/transaction_entity.dart';

abstract class IGetTransactionsDatasource {
  Future<Either<Exception, List<TransactionEntity>>> call();
}
