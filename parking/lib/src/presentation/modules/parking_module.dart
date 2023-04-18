import 'package:core/core.dart';
import 'package:wallet/wallet.dart';

import '../../data/datasources/parking/parking_datasource.dart';
import '../../infra/repositories/parking/parking_repository.dart';
import '../../infra/usecases/parking/parking_usecase.dart';
import '../controllers/parking/parking_controller.dart';
import '../controllers/parking/parking_coupon_controller.dart';
import '../controllers/parking/parking_ticket_controller.dart';
import '../controllers/ticket/scan_ticket_controller.dart';
import '../pages/parking/enter_ticket_number_page.dart';
import '../pages/parking/parking_amount_info_page.dart';
import '../pages/parking/parking_page.dart';
import '../pages/parking/parking_regulation_page.dart';
import '../pages/parking/scan_ticket_page.dart';
import '../routes/coupon_routes.dart';
import '../routes/desk_routes.dart';
import '../routes/parking_routes.dart';
import '../routes/ticket_routes.dart';
import '../routes/ticket_window_routes.dart';
import '../routes/vehicles_routes.dart';
import 'coupon_module.dart';
import 'desk_module.dart';
import 'ticket_module.dart';
import 'ticket_window_module.dart';
import 'vehicles_module.dart';

class ParkingModule extends Module {
  ParkingModule({
    required BasePath<WalletRoutes> walletPath,
    required BasePath<ParkingRoutes> parentPath,
  }) {
    _walletPath = walletPath;
    _parentPath = parentPath;
  }

  static late final BasePath<WalletRoutes> _walletPath;
  static late final BasePath<ParkingRoutes> _parentPath;

  @override
  final List<Bind> binds = [
    /// Parking
    Bind.factory<ParkingDatasource>(
      (i) => ParkingDatasource(
        client: i.get<DioClientDriver>(),
        storageDriver: i.get<FirebaseStorageDriver>(),
        baseUrl: i.get<EnvironmentEntity>().baseUrlParking,
      ),
    ),
    Bind.factory<ParkingRepository>(
      (i) => ParkingRepository(datasource: i.get<ParkingDatasource>()),
    ),
    Bind.factory<ParkingUsecase>(
      (i) => ParkingUsecase(
        repository: i.get<ParkingRepository>(),
        session: i.get<SessionEntity>(),
      ),
    ),

    Bind.factory<BasePath<WalletRoutes>>((i) => _walletPath),
    Bind.factory<BasePath<ParkingRoutes>>((i) => _parentPath),

    /// Controllers
    Bind.lazySingleton<ParkingController>(
      (i) => ParkingController(
        usecase: i.get<ParkingUsecase>(),
        couponController: i.get<ParkingCouponController>(),
        ticketController: i.get<ParkingTicketController>(),
      ),
    ),
    Bind.factory<ParkingCouponController>(
      (i) => ParkingCouponController(
        usecase: i.get<ParkingUsecase>(),
      ),
    ),
    Bind.factory<ParkingTicketController>(
      (i) => ParkingTicketController(
        usecase: i.get<ParkingUsecase>(),
      ),
    ),
    Bind.factory<CodeScanController>((i) => CodeScanController()),
    Bind.factory<ScanTicketController>(
      (i) => ScanTicketController(
        scanController: DM.i.get<CodeScanController>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const ParkingPage()),
    ChildRoute(
      ParkingRoutes.parkingAmountInfo.path,
      child: (_, args) => ParkingAmountInfoPage(
        coupon: args.data['coupon'],
        ticketOrPlate: args.data['ticketOrPlate'],
      ),
    ),
    ChildRoute(
      ParkingRoutes.scanTicket.path,
      child: (_, args) => ScanTicketPage(onScanCode: args.data),
    ),
    ChildRoute(
      ParkingRoutes.regulation.path,
      child: (_, args) => ParkingRegulationPage(rulesUrl: args.data),
    ),
    ChildRoute(
      ParkingRoutes.enterTicketNumber.path,
      child: (_, args) => const EnterTicketNumberPage(),
    ),
    ModuleRoute(DeskRoutes.root.path, module: GenDeskModule()),
    ModuleRoute(TicketRoutes.root.path, module: TicketModule()),
    ModuleRoute(CouponRoutes.root.path, module: CouponModule()),
    ModuleRoute(TicketWindowRoutes.root.path, module: TicketWindowModule()),
    ModuleRoute(VehiclesRoutes.root.path, module: VehiclesModule()),
  ];
}
