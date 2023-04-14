import 'package:core/core.dart';

import '../../../domain/entities/credit_card_entity.dart';

abstract class ICreditCardDatasource {
  Future<Either<Exception, Unit>> createCreditCardValidation({
    required String creditCardId,
    required String securityCode,
  });
  Future<Either<Exception, CreditCardEntity>> createCreditCard({
    required CreditCardEntity creditCard,
  });
  Future<Either<Exception, String>> createCreditCardToken({
    required String cardNumber,
  });
  Future<Either<Exception, Unit>> confirmCreditCardValidation({
    required String amountCents,
    required String creditCardId,
  });
  Future<Either<Exception, Unit>> changeFavoriteCreditCard({
    required String cardId,
    required bool isFavorite,
  });
  Future<Either<Exception, List<CreditCardEntity>>> fetchCreditCards({
    required String customerId,
  });
  Future<Either<Exception, Unit>> removeCreditCardById({
    required String cardId,
  });
  Future<Either<Exception, CreditCardEntity>> fetchFavoriteCreditCard({
    required String customerId,
  });
}
