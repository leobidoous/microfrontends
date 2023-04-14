import 'package:core/core.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/repositories/wallet/i_wallet_repository.dart';
import '../../datasources/wallet/i_wallet_datasource.dart';

class WalletRepository extends IWalletRepository {
  final IWalletDatasource datasource;

  WalletRepository({required this.datasource});
  @override
  Future<Either<Exception, List<TransactionEntity>>> fetchTransactions({
    PaginationEntity? pagination,
    required String customerId,
  }) async {
    return await datasource.fetchTransactions(
      pagination: pagination,
      customerId: customerId,
    );
  }
}
