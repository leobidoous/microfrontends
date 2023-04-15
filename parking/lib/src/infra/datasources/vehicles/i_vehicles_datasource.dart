import 'package:core/core.dart';

import '../../../domain/failures/vehicles/vehicle_failure.dart';
import '../../models/vehicles/add_vehicle_model.dart';

abstract class IVehiclesDatasource {
  Future<Either<Exception, List<Map<String, dynamic>>>> fetchVehicles();
  Future<Either<Exception, Map<String, dynamic>>> removeVehicle({
    required int idVehicle,
  });
  Future<Either<IVehiclesFailures, Map<String, dynamic>>> addVehicle({
    AddVehicleModel? addVehicleEntity,
  });
  Future<Either<IVehiclesFailures, List<Map<String, dynamic>>>>
      searchVehicleBrands();
  Future<Either<IVehiclesFailures, List<Map<String, dynamic>>>>
      searchVehicleModels({required int idBrand});
}
