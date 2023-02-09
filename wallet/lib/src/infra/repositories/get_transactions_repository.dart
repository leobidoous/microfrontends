import 'package:core/core.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/get_transactions_repository.dart';
import '../datasources/get_transactions_datasource.dart';

class GetTransactionsRepository extends IGetTransactionsRepository {
  final IGetTransactionsDatasource datasource;
  GetTransactionsRepository({required this.datasource});

  @override
  Future<Either<Exception, List<TransactionEntity>>> call() {
    return datasource();
  }
}
