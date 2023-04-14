import 'package:core/core.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/usecases/credit_card/i_credit_card_usecase.dart';
import '../../../infra/models/credit_card_model.dart';

class FetchFavoriteCreditCardsController
    extends GenController<Exception, CreditCardEntity> {
  final ICreditCardUsecase usecase;

  FetchFavoriteCreditCardsController({
    required this.usecase,
  }) : super(CreditCardModel.fromMap({}));

  Future<void> fetchCreditCards() async {
    await execute(() => usecase.fetchFavoriteCreditCard());
  }
}
