import 'package:core/core.dart';

import '../../../domain/failures/vehicles/vehicle_failure.dart';
import '../../../domain/repositories/vehicles/i_vehicles_repository.dart';
import '../../../domain/usecases/vehicles/i_vehicles_usecase.dart';
import '../../models/vehicles/add_vehicle_model.dart';
import '../../models/vehicles/brand_vehicle_model.dart';
import '../../models/vehicles/model_vehicle_model.dart';
import '../../models/vehicles/remove_vehicle_model.dart';
import '../../models/vehicles/vehicle_model.dart';

class VehiclesUsecases extends IVechicleUsecase {
  VehiclesUsecases({required this.repository});

  final IVehiclesRepository repository;

  @override
  Future<Either<Exception, List<VehicleModel>>> fetchVehicles() async {
    return repository.fetchVehicles();
  }

  @override
  Future<Either<Exception, RemoveVehicleModel>> removeVehicle({
    required int idVehicle,
  }) {
    return repository.removeVehicle(idVehicle: idVehicle);
  }

  @override
  Future<Either<IVehiclesFailures, AddVehicleModel>> addVehicle({
    required AddVehicleModel? addVehicleEntity,
  }) {
    return repository.addVehicle(addVehicleEntity: addVehicleEntity);
  }

  @override
  Future<Either<IVehiclesFailures, List<BrandVehicleModel>>>
      searchVehicleBrands() async {
    return repository.searchVehicleBrands();
  }

  @override
  Future<Either<IVehiclesFailures, List<ModelVehicleModel>>>
      searchVehicleModels({required int idBrand}) async {
    return repository.searchVehicleModels(idBrand: idBrand);
  }
}
