import 'package:core/core.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../infra/datasources/credit_card/i_credit_card_datasource.dart';
import '../../../infra/models/credit_card_model.dart';
import '../../../presentation/graphql/mutations/credit_card_mutations.dart';
import '../../../presentation/graphql/queries/credit_card_queries.dart';

class CreditCardDatasource extends ICreditCardDatasource {
  final IFirebaseStorageDriver storageDriver;
  final IGraphQlDriver graphQlClient;

  CreditCardDatasource({
    required this.storageDriver,
    required this.graphQlClient,
  });

  @override
  Future<Either<Exception, Unit>> changeFavoriteCreditCard({
    required String cardId,
    required bool isFavorite,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CreditCardMutations.updateCreditCard,
        variables: {
          'id': cardId,
          'params': {'default': isFavorite},
        },
        options: GraphQlDriverOptions(operationName: 'updateCreditCard'),
      ),
    );
    return response.fold((l) => Left(Exception(l.message)), (r) => Right(unit));
  }

  @override
  Future<Either<Exception, Unit>> confirmCreditCardValidation({
    required String amountCents,
    required String creditCardId,
  }) async {
    final response = await storageDriver.cloudFunction(
      name: 'confirmCreditCardValidation',
      data: {
        'creditCardId': creditCardId,
        'amountCents': amountCents,
      },
    );
    return response.fold((l) => Left(Exception(l.data)), (r) => Right(unit));
  }

  @override
  Future<Either<Exception, CreditCardEntity>> createCreditCard({
    required CreditCardEntity creditCard,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CreditCardMutations.createCreditCard,
        variables: {'params': CreditCardModel.fromEntity(creditCard).toMap},
        options: GraphQlDriverOptions(operationName: 'createCreditCard'),
      ),
    );
    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          final data = Map<String, dynamic>.from(r.data['createCreditCard']);
          return Right(CreditCardModel.fromMap(data));
        } catch (e) {
          return Right(CreditCardModel.fromMap({}));
        }
      },
    );
  }

  @override
  Future<Either<Exception, String>> createCreditCardToken({
    required String cardNumber,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CreditCardMutations.tokenizeCardNumber,
        variables: {'cardNumber': cardNumber},
        options: GraphQlDriverOptions(operationName: 'tokenizeCardNumber'),
      ),
    );
    return response.fold((l) => Left(Exception(l.message)), (r) {
      try {
        return Right(r.data['tokenizeCardNumber']);
      } catch (e, s) {
        return Left(Exception('$e $s'));
      }
    });
  }

  @override
  Future<Either<Exception, Unit>> createCreditCardValidation({
    required String creditCardId,
    required String securityCode,
  }) async {
    final response = await storageDriver.cloudFunction(
      name: 'createCreditCardValidation',
      data: {
        'creditCardId': creditCardId,
        'securityCode': securityCode,
      },
    );
    return response.fold((l) => Left(Exception(l.data)), (r) => Right(unit));
  }

  @override
  Future<Either<Exception, List<CreditCardEntity>>> fetchCreditCards({
    required String customerId,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CreditCardQueries.listCreditCards,
        variables: {'customerId': customerId},
        options: GraphQlDriverOptions(operationName: 'listCreditCards'),
      ),
    );

    return response.fold(
      (l) => Left(Exception(l.message)),
      (r) {
        try {
          return Right(
            ((r.data['listCreditCards'] ?? []) as List)
                .map((e) => CreditCardModel.fromMap(e))
                .toList(),
          );
        } catch (e, s) {
          return Left(Exception('$e $s'));
        }
      },
    );
  }

  @override
  Future<Either<Exception, Unit>> removeCreditCardById({
    required String cardId,
  }) async {
    final response = await graphQlClient.request(
      data: GraphRequestData(
        document: CreditCardMutations.deleteCreditCard,
        variables: {'id': cardId},
        options: GraphQlDriverOptions(operationName: 'deleteCreditCard'),
      ),
    );
    return response.fold((l) => Left(Exception(l.message)), (r) => Right(unit));
  }

  @override
  Future<Either<Exception, CreditCardEntity>> fetchFavoriteCreditCard({
    required String customerId,
  }) async {
    final response = await fetchCreditCards(customerId: customerId);
    return response.fold(
      (l) => Left(l),
      (r) async {
        for (CreditCardEntity card in r) {
          if (card.isFavorite) return Right(card);
        }
        if (r.isNotEmpty) return Right(r.first);
        return Left(Exception());
      },
    );
  }
}
