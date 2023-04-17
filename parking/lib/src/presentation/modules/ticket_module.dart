import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../infra/usecases/parking/parking_usecase.dart';
import '../controllers/ticket/ticket_payment_controller.dart';
import '../controllers/ticket/ticket_payment_method_controller.dart';
import '../controllers/ticket/ticket_submit_controller.dart';
import '../pages/ticket/ticket_submit/ticket_submit_page.dart';

class TicketModule extends Module {
  @override
  final List<Bind> binds = [
    /// Credit card
    ...AddCreditCardModule.exportedBinds,

    /// Controllers
    Bind.factory<TicketSubmitController>(
      (i) => TicketSubmitController(usecase: DM.i.get<ParkingUsecase>()),
    ),
    Bind.factory<TicketPaymentMethodController>(
      (i) => TicketPaymentMethodController(
        usecase: DM.i.get<CreditCardUsecase>(),
      ),
    ),
    Bind.factory<TicketPaymentController>(
      (i) => TicketPaymentController(usecase: DM.i.get<ParkingUsecase>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => TicketSubmitPage(args: args.data),
    ),
  ];
}
