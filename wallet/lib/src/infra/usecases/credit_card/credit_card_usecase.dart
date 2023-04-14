import 'package:core/core.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/repositories/credit_card/i_credit_card_repository.dart';
import '../../../domain/usecases/credit_card/i_credit_card_usecase.dart';

class CreditCardUsecase extends ICreditCardUsecase {
  final ICreditCardRepository repository;
  final SessionEntity session;

  CreditCardUsecase({
    required this.repository,
    required this.session,
  });

  @override
  Future<Either<Exception, Unit>> updateFavoriteCreditCard({
    required String cardId,
    required bool isFavorite,
  }) {
    return repository.changeFavoriteCreditCard(
      cardId: cardId,
      isFavorite: isFavorite,
    );
  }

  @override
  Future<Either<Exception, Unit>> confirmCreditCardValidation({
    required String amountCents,
    required String creditCardId,
  }) {
    return repository.confirmCreditCardValidation(
      amountCents: amountCents,
      creditCardId: creditCardId,
    );
  }

  @override
  Future<Either<Exception, CreditCardEntity>> createCreditCard({
    required CreditCardEntity creditCard,
  }) {
    return repository.createCreditCard(
      creditCard: creditCard,
    );
  }

  @override
  Future<Either<Exception, String>> createCreditCardToken({
    required String cardNumber,
  }) {
    return repository.createCreditCardToken(cardNumber: cardNumber);
  }

  @override
  Future<Either<Exception, Unit>> createCreditCardValidation({
    required String creditCardId,
    required String securityCode,
  }) {
    return repository.createCreditCardValidation(
      creditCardId: creditCardId,
      securityCode: securityCode,
    );
  }

  @override
  Future<Either<Exception, List<CreditCardEntity>>> fetchCreditCards() {
    return repository.fetchCreditCards(customerId: session.customer.id);
  }

  @override
  Future<Either<Exception, CreditCardEntity>> fetchFavoriteCreditCard() {
    return repository.fetchFavoriteCreditCard(customerId: session.customer.id);
  }

  @override
  Future<Either<Exception, Unit>> removeCreditCardById({
    required String cardId,
  }) {
    return repository.removeCreditCardById(cardId: cardId);
  }
}
