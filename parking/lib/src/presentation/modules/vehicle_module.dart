import 'package:core/core.dart';

import '../../data/datasources/vehicles/vehicles_datasource.dart';
import '../../infra/repositories/vehicles/vehicles_repository.dart';
import '../../infra/usecases/vehicles/vehicles_usecase.dart';
import '../controllers/parking/parking_enter_plate_number_controller.dart';
import '../controllers/vehicles/add_vehicle_controller.dart';
import '../controllers/vehicles/vehicle_list_controller.dart';
import '../pages/parking/enter_plate_number_page.dart';

class VehicleModule extends Module {
  @override
  final List<Bind> binds = [
    /// vehicles
    Bind.factory<VehiclesDatasource>(
      (i) => VehiclesDatasource(
        client: DM.i.get<DioClientDriver>(),
        baseUrl: DM.i.get<EnvironmentEntity>().baseUrlParking,
      ),
    ),

    Bind.factory<VehicleRepository>(
      (i) => VehicleRepository(datasource: DM.i.get<VehiclesDatasource>()),
    ),

    Bind.factory<VehiclesUsecase>(
      (i) => VehiclesUsecase(repository: DM.i.get<VehicleRepository>()),
    ),

    /// Controllers
    Bind.lazySingleton<ParkingEnterPlateNumberController>(
      (i) => ParkingEnterPlateNumberController(
        usecase: DM.i.get<VehiclesUsecase>(),
      ),
    ),
    Bind.lazySingleton<VehicleListController>(
      (i) => VehicleListController(usecase: DM.i.get<VehiclesUsecase>()),
    ),
    Bind.lazySingleton<AddVehicleController>(
      (i) => AddVehicleController(usecase: DM.i.get<VehiclesUsecase>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => const EnterPlateNumberPage(),
    ),
  ];
}
