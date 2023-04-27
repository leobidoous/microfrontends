import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../data/datasources/parking/parking_datasource.dart';
import '../../infra/repositories/parking/parking_repository.dart';
import '../../infra/usecases/parking/parking_usecase.dart';
import '../controllers/parking/parking_ticket_controller.dart';
import '../controllers/ticket/payment_voucher_controller.dart';
import '../controllers/ticket/ticket_payment_controller.dart';
import '../controllers/ticket/ticket_payment_method_controller.dart';
import '../controllers/ticket/ticket_submit_controller.dart';
import '../controllers/ticket/ticket_voucher_details_controller.dart';
import '../controllers/ticket/tracking/ticket_count_down_controller.dart';
import '../controllers/ticket/tracking/ticket_history_controller.dart';
import '../pages/ticket/ticket_submit/ticket_submit_page.dart';
import '../pages/ticket/ticket_tracking/ticket_tracking_page.dart';
import '../pages/ticket/ticket_voucher_details/ticket_voucher_details_page.dart';
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
    Bind.factory<TicketVoucherDetailsController>(
      (i) => TicketVoucherDetailsController(
        usecase: i.get<ParkingUsecase>(),
      ),
    ),
    Bind.factory<PaymentVoucherController>(
      (i) => PaymentVoucherController(),
    ),

    // Usecase
    Bind.factory<ParkingUsecase>(
      (i) => ParkingUsecase(
        repository: i.get<ParkingRepository>(),
        session: i.get<SessionEntity>(),
      ),
    ),
    // Repository
    Bind.factory<ParkingRepository>(
      (i) => ParkingRepository(
        datasource: i.get<ParkingDatasource>(),
      ),
    ),
    // Datasource
    Bind.factory<ParkingDatasource>(
      (i) => ParkingDatasource(
        baseUrl: DM.i.get<EnvironmentEntity>().baseUrlParking,
        client: DM.i.get<DioClientDriver>(),
        storageDriver: i.get<FirebaseStorageDriver>(),
      ),
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
    ChildRoute(
      TicketRoutes.ticketVoucherDetails.path,
      child: (_, args) => TicketVoucherDetailsPage(
        ticketPayment: args.data[0],
        creditCard: args.data[1],
      ),
    ),
  ];
}
