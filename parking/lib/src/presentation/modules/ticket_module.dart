import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../infra/usecases/parking/parking_usecase.dart';
import '../controllers/parking/parking_ticket_controller.dart';
import '../controllers/ticket/ticket_payment_controller.dart';
import '../controllers/ticket/ticket_payment_method_controller.dart';
import '../controllers/ticket/ticket_submit_controller.dart';
import '../controllers/ticket/tracking/ticket_count_down_controller.dart';
import '../controllers/ticket/tracking/ticket_history_controller.dart';
import '../pages/ticket/ticket_submit/ticket_submit_page.dart';
import '../pages/ticket/ticket_tracking/ticket_tracking_page.dart';
import '../routes/ticket_routes.dart';

class TicketModule extends Module {
  @override
  final List<Bind> binds = [
    /// Credit card
    ...AddCreditCardModule.exportedBinds,

    /// Controllers
    Bind.factory<TicketSubmitController>(
      (i) => TicketSubmitController(usecase: i.get<ParkingUsecase>()),
    ),
    Bind.factory<TicketPaymentMethodController>(
      (i) => TicketPaymentMethodController(
        usecase: i.get<CreditCardUsecase>(),
      ),
    ),
    Bind.factory<TicketPaymentController>(
      (i) => TicketPaymentController(usecase: i.get<ParkingUsecase>()),
    ),

    Bind.lazySingleton<TicketHistoryController>(
      (i) => TicketHistoryController(usecase: i.get<ParkingUsecase>()),
    ),
    Bind.factory<ParkingTicketController>(
      (i) => ParkingTicketController(usecase: i.get<ParkingUsecase>()),
    ),

    Bind.factory<TicketCountDownController>(
      (i) => TicketCountDownController(),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => TicketSubmitPage(args: args.data),
    ),
    ChildRoute(
      TicketRoutes.ticketTracking.path,
      child: (_, args) => const TicketTrackingPage(),
    ),
  ];
}
