import 'package:core/core.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/repositories/wallet/i_wallet_repository.dart';
import '../../../domain/usecases/wallet/i_wallet_usecase.dart';

class WalletUsecase extends IWalletUsecase {
  final IWalletRepository repository;
  final SessionEntity session;

  WalletUsecase({required this.repository, required this.session});

  @override
  Future<Either<Exception, List<TransactionEntity>>> fetchTransactions({
    PaginationEntity? pagination,
  }) async {
    return await repository.fetchTransactions(
      pagination: pagination,
      customerId: session.customer.id,
    );
  }
}
