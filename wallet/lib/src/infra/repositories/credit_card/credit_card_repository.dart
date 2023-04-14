import 'package:core/core.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/repositories/credit_card/i_credit_card_repository.dart';
import '../../datasources/credit_card/i_credit_card_datasource.dart';

class CreditCardRepository extends ICreditCardRepository {
  final ICreditCardDatasource datasource;

  CreditCardRepository({required this.datasource});

  @override
  Future<Either<Exception, Unit>> changeFavoriteCreditCard({
    required String cardId,
    required bool isFavorite,
  }) {
    return datasource.changeFavoriteCreditCard(
      cardId: cardId,
      isFavorite: isFavorite,
    );
  }

  @override
  Future<Either<Exception, Unit>> confirmCreditCardValidation({
    required String amountCents,
    required String creditCardId,
  }) {
    return datasource.confirmCreditCardValidation(
      amountCents: amountCents,
      creditCardId: creditCardId,
    );
  }

  @override
  Future<Either<Exception, CreditCardEntity>> createCreditCard({
    required CreditCardEntity creditCard,
  }) {
    return datasource.createCreditCard(
      creditCard: creditCard,
    );
  }

  @override
  Future<Either<Exception, String>> createCreditCardToken({
    required String cardNumber,
  }) {
    return datasource.createCreditCardToken(cardNumber: cardNumber);
  }

  @override
  Future<Either<Exception, Unit>> createCreditCardValidation({
    required String creditCardId,
    required String securityCode,
  }) {
    return datasource.createCreditCardValidation(
      creditCardId: creditCardId,
      securityCode: securityCode,
    );
  }

  @override
  Future<Either<Exception, List<CreditCardEntity>>> fetchCreditCards({
    required String customerId,
  }) {
    return datasource.fetchCreditCards(customerId: customerId);
  }

  @override
  Future<Either<Exception, Unit>> removeCreditCardById({
    required String cardId,
  }) {
    return datasource.removeCreditCardById(cardId: cardId);
  }

  @override
  Future<Either<Exception, CreditCardEntity>> fetchFavoriteCreditCard({
    required String customerId,
  }) {
    return datasource.fetchFavoriteCreditCard(customerId: customerId);
  }
}
