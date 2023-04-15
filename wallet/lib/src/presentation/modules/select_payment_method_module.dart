import 'package:core/core.dart';

import '../../infra/usecases/credit_card/credit_card_usecase.dart';
import '../controllers/credit_card/fetch_credit_cards_controller.dart';
import '../controllers/credit_card/remove_credit_card_controller.dart';
import '../controllers/select_payment_method/select_payment_method_controller.dart';
import '../pages/select_payment_method/select_payment_method_page.dart';
import 'add_credit_card_module.dart';

class SelectPaymentMethodModule extends Module {
  static List<Bind> get exportedBinds => [
        /// Credit card
        ...AddCreditCardModule.exportedBinds,

        /// Controllers
        Bind.factory<SelectPaymentMethodController>(
          (i) => SelectPaymentMethodController(
            removeCardController: i.get<RemoveCreditCardController>(),
            cardsController: i.get<FetchCreditCardsController>(),
          ),
        ),
        Bind.factory(
          (i) =>
              RemoveCreditCardController(usecase: i.get<CreditCardUsecase>()),
        ),
        Bind.factory(
          (i) =>
              FetchCreditCardsController(usecase: i.get<CreditCardUsecase>()),
        ),
      ];
  @override
  final List<Bind> binds = [
    /// Select payment method
    ...exportedBinds,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => SelectPaymentMethodPage(
        onSelected: args.data['onSelected'],
      ),
    ),
  ];
}
