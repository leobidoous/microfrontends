import 'package:core/core.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/enums/transaction_method.dart';
import '../../../infra/datasources/wallet/i_wallet_datasource.dart';
import '../../../infra/models/transaction_model.dart';
import '../../../presentation/graphql/queries/transaction_queries.dart';

class WalletDatasource extends IWalletDatasource {
  WalletDatasource({
    required this.storageDriver,
    required this.graphQlClient,
  });

  final IFirebaseStorageDriver storageDriver;
  final IGraphQlDriver graphQlClient;

  @override
  Future<Either<Exception, List<TransactionEntity>>> fetchTransactions({
    PaginationEntity? pagination,
    required String customerId,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: TransactionQueries.listCustomerPayments,
        variables: {
          'customerId': customerId,
          'pagination': pagination != null
              ? PaginationModel.fromEntity(pagination).toMap
              : null,
          'filters': {
            'method': [
              TransactionMethod.bankSlip.toJson,
              TransactionMethod.creditCard.toJson,
              TransactionMethod.pix.toJson,
              TransactionMethod.wallet.toJson,
            ]
          }
        },
        options: GraphQlDriverOptions(
          operationName: 'listCustomerPayments',
        ),
      ),
    );
    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          return Right(
            (r.data['listCustomerPayments'] as List)
                .map((e) => TransactionModel.fromMap(e))
                .toList(),
          );
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }
}
