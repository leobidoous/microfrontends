import 'package:core/core.dart';

import '../../data/datasources/vehicles/vehicles_datasource.dart';
import '../../infra/repositories/vehicles/vehicles_repository.dart';

import '../../infra/usecases/vehicles/vehicles_usecase.dart';
import '../controllers/parking/parking_enter_plate_number_controller.dart';
import '../controllers/vehicles/add_vehicle_controller.dart';
import '../controllers/vehicles/vehicle_list_controller.dart';
import '../pages/parking/enter_plate_number_page.dart';
import '../pages/vehicles/add_vehicle_page.dart';
import '../pages/vehicles/vehicles_page.dart';
import '../routes/vehicles_routes.dart';

class VehiclesModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        // controllers
        Bind.lazySingleton<ParkingEnterPlateNumberController>(
          (i) => ParkingEnterPlateNumberController(
            usecase: i.get<VehiclesUsecase>(),
          ),
        ),
        Bind.factory<VehicleListController>(
          (i) => VehicleListController(
            usecase: i.get<VehiclesUsecase>(),
          ),
        ),
        Bind.lazySingleton<AddVehicleController>(
          (i) => AddVehicleController(
            usecase: i.get<VehiclesUsecase>(),
          ),
        ),

        // usecases
        Bind.lazySingleton<VehiclesUsecase>(
          (i) => VehiclesUsecase(
            repository: i.get<VehicleRepository>(),
          ),
        ),

        // repository
        Bind.lazySingleton<VehicleRepository>(
          (i) => VehicleRepository(
            datasource: i.get<VehiclesDatasource>(),
          ),
        ),

        // datasource
        Bind.lazySingleton<VehiclesDatasource>(
          (i) => VehiclesDatasource(
            baseUrl: DM.i.get<EnvironmentEntity>().baseUrlParking,
            client: DM.i.get<DioClientDriver>(),
          ),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          Modular.initialRoute,
          child: (_, args) => const VehiclesPage(),
        ),
        ChildRoute(
          VehiclesRoutes.addVehicle.path,
          child: (_, args) => const AddVehiclePage(),
        ),
        ChildRoute(
          VehiclesRoutes.enterPlateNumber.path,
          child: (_, args) => const EnterPlateNumberPage(),
        ),
      ];
}
