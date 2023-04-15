import 'package:core/core.dart';

import '../../../infra/models/vehicles/add_vehicle_model.dart';
import '../../../infra/models/vehicles/brand_vehicle_model.dart';
import '../../../infra/models/vehicles/model_vehicle_model.dart';
import '../../../infra/models/vehicles/remove_vehicle_model.dart';
import '../../../infra/models/vehicles/vehicle_model.dart';
import '../../failures/vehicles/vehicle_failure.dart';

abstract class IVechicleUsecase {
  Future<Either<Exception, List<VehicleModel>>> fetchVehicles();
  Future<Either<Exception, RemoveVehicleModel>> removeVehicle({
    required int idVehicle,
  });

  Future<Either<IVehiclesFailures, AddVehicleModel>> addVehicle({
    required AddVehicleModel? addVehicleEntity,
  });
  Future<Either<IVehiclesFailures, List<BrandVehicleModel>>>
      searchVehicleBrands();
  Future<Either<IVehiclesFailures, List<ModelVehicleModel>>>
      searchVehicleModels({required int idBrand});
}
