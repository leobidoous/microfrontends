import 'package:core/core.dart';

import '../../domain/entities/credit_card_entity.dart';
import '../../domain/usecases/credit_card/i_credit_card_usecase.dart';

class ChangeFavoriteCardController extends GenController<Exception, Unit> {
  final ICreditCardUsecase usecase;
  final SessionEntity session;

  ChangeFavoriteCardController({
    required this.usecase,
    required this.session,
  }) : super(unit);

  CreditCardEntity? favoriteCreditCard;

  Future<void> updateFavoriteCreditCard(String cardId, bool isFavorite) async {
    await execute(
      () => usecase.updateFavoriteCreditCard(
        isFavorite: isFavorite,
        cardId: cardId,
      ),
    );
  }

  void onChangingFavorite(CreditCardEntity creditCard) {
    favoriteCreditCard = creditCard;
  }

  bool isChangingFavorite(CreditCardEntity creditCard) {
    return creditCard == favoriteCreditCard && isLoading;
  }
}
