import 'package:core/core.dart';

import '../entities/transaction_entity.dart';
import '../repositories/get_transactions_repository.dart';

abstract class IGetTransactionsUsecase {
  Future<Either<Exception, List<TransactionEntity>>> call();
}

class GetTransactionsUsecase extends IGetTransactionsUsecase {
  final IGetTransactionsRepository repository;
  GetTransactionsUsecase({required this.repository});

  @override
  Future<Either<Exception, List<TransactionEntity>>> call() {
    return repository();
  }
}
