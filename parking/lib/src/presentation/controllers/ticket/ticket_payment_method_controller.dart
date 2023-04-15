import 'package:core/core.dart';
import 'package:wallet/wallet.dart';


class TicketPaymentMethodController
    extends GenController<Exception, CreditCardEntity> {
  TicketPaymentMethodController({
    required this.usecase,
  }) : super(CreditCardModel.fromMap({}));

  final ICreditCardUsecase usecase;

  Future<void> fetchFavoriteCreditCard() async {
    await execute(() => usecase.fetchFavoriteCreditCard());
  }

  void onChangeCard(CreditCardEntity card) {
    update(card);
  }
}
