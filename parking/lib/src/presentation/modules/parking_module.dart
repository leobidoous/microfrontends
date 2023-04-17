import 'package:core/core.dart';

import '../../data/datasources/parking/parking_datasource.dart';
import '../../infra/repositories/parking/parking_repository.dart';
import '../../infra/usecases/parking/parking_usecase.dart';
import '../controllers/parking/parking_controller.dart';
import '../controllers/parking/parking_coupon_controller.dart';
import '../controllers/parking/parking_ticket_controller.dart';
import '../pages/parking/parking_amount_info_page.dart';
import '../pages/parking/parking_page.dart';
import '../routes/parking_routes.dart';
import '../routes/ticket_routes.dart';
import 'ticket_module.dart';

class ParkingModule extends Module {
  @override
  final List<Bind> binds = [
    /// Parking dashboard
    Bind.factory<ParkingDatasource>(
      (i) => ParkingDatasource(
        client: i.get<DioClientDriver>(),
        storageDriver: i.get<FirebaseStorageDriver>(),
        baseUrl: i.get<EnvironmentEntity>().baseUrlParking,
      ),
    ),
    Bind.factory<ParkingRepository>(
      (i) => ParkingRepository(
        datasource: i.get<ParkingDatasource>(),
      ),
    ),
    Bind.factory<ParkingUsecase>(
      (i) => ParkingUsecase(
        repository: i.get<ParkingRepository>(),
        session: i.get<SessionEntity>(),
      ),
    ),

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
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const ParkingPage(),
    ),
    ChildRoute(
      ParkingRoutes.parkingAmountInfo.path,
      child: (_, args) => ParkingAmountInfoPage(
        coupon: args.data['coupon'],
        ticketOrPlate: args.data['ticketOrPlate'],
      ),
    ),
    ModuleRoute(TicketRoutes.root.path, module: TicketModule()),
  ];
}
