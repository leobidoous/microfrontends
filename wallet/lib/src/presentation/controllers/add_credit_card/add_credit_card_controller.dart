import 'package:core/core.dart';

import '../../../domain/entities/billing_address_entity.dart';
import '../../../domain/entities/credit_card_entity.dart';
import '../../../domain/usecases/credit_card/i_credit_card_usecase.dart';
import '../../../infra/models/credit_card_model.dart';

class AddCreditCardController
    extends GenController<Exception, CreditCardEntity> {
  final ICreditCardUsecase usecase;
  final SessionEntity session;

  AddCreditCardController({
    required this.usecase,
    required this.session,
  }) : super(CreditCardModel.fromMap({}).toEntity);

  Future<void> createCreditCard(BillingAddressEntity billingAddress) async {
    state.billingAddress = billingAddress;
    state.customerId = session.customer.id;
    state.marketplaceId = session.customer.marketplaceId;

    await execute(() async {
      final token = await usecase.createCreditCardToken(
        cardNumber: state.cardNumber,
      );
      return token.fold((l) => Left(l), (r) async {
        state.token = r;
        return usecase.createCreditCard(creditCard: state);
      });
    });
  }
}
