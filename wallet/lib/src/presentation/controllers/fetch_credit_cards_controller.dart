import 'package:core/core.dart';

import '../../domain/entities/credit_card_entity.dart';
import '../../domain/usecases/credit_card/i_credit_card_usecase.dart';

class FetchCreditCardsController
    extends GenController<Exception, List<CreditCardEntity>> {
  final ICreditCardUsecase usecase;

  FetchCreditCardsController({required this.usecase}) : super([]);

  Future<void> fetchCreditCards() async {
    execute(() => usecase.fetchCreditCards());
  }

  void addNewCreditCard(CreditCardEntity creditCard) {
    update([creditCard, ...state]);
  }
}
