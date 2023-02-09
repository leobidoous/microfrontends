import 'package:core/core.dart';

import '../../domain/entities/transaction_entity.dart';
import '../../infra/datasources/get_transactions_datasource.dart';
import '../../infra/models/transaction_model.dart';

class GetTransactionsDatasource extends IGetTransactionsDatasource {
  @override
  Future<Either<Exception, List<TransactionEntity>>> call() async {
    await Future.delayed(const Duration(seconds: 1));
    final response = await LoadJson.fromAsset('assets/mocks/transactions.json');
    return response.fold(
      (l) => Left(l),
      (r) async {
        try {
          final transactions = (r['transactions'] as List)
              .map((e) => TransactionModel.fromMap(e))
              .toList();
          return Right(transactions);
        } catch (e) {
          return Left(Exception(e));
        }
      },
    );
  }
}
