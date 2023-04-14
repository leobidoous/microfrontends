import 'package:core/core.dart';

import '../../../domain/entities/credit_card_entity.dart';
import '../../../infra/models/credit_card_model.dart';
import '../credit_card/fetch_credit_cards_controller.dart';
import '../credit_card/remove_credit_card_controller.dart';

class SelectPaymentMethodController
    extends GenController<Exception, CreditCardEntity> {
  final FetchCreditCardsController cardsController;
  final RemoveCreditCardController removeCardController;

  SelectPaymentMethodController({
    required this.cardsController,
    required this.removeCardController,
  }) : super(CreditCardModel.fromMap({}));

  void onChangeSelectedPaymentMethod(CreditCardEntity creditCard) {
    update(creditCard);
  }
}
