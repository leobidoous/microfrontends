import 'package:core/core.dart';

import '../../../domain/usecases/credit_card/i_credit_card_usecase.dart';

class RemoveCreditCardController extends GenController<Exception, Unit> {
  final ICreditCardUsecase usecase;

  RemoveCreditCardController({required this.usecase}) : super(unit);

  Future<void> removeCreditCardById(String cardId) async {
    await execute(() => usecase.removeCreditCardById(cardId: cardId));
  }
}
