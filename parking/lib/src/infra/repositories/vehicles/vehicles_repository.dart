import 'package:core/core.dart';

import '../../../domain/failures/vehicles/vehicle_failure.dart';
import '../../../domain/repositories/vehicles/i_vehicles_repository.dart';
import '../../datasources/vehicles/i_vehicles_datasource.dart';
import '../../models/vehicles/add_vehicle_model.dart';
import '../../models/vehicles/brand_vehicle_model.dart';
import '../../models/vehicles/model_vehicle_model.dart';
import '../../models/vehicles/remove_vehicle_model.dart';
import '../../models/vehicles/vehicle_model.dart';

class VehicleRepository extends IVehiclesRepository {
  VehicleRepository({required this.datasource});

  final IVehiclesDatasource datasource;

  @override
  Future<Either<Exception, List<VehicleModel>>> fetchVehicles() async {
    final response = await datasource.fetchVehicles();

    return response.fold((l) => Left(l), (r) {
      if (r.isEmpty) return Right([]);
      return Right(
        r.map((element) => VehicleModel.fromMap(element)).toList(),
      );
    });
  }

  @override
  Future<Either<Exception, RemoveVehicleModel>> removeVehicle({
    required int idVehicle,
  }) async {
    final response = await datasource.removeVehicle(idVehicle: idVehicle);
    return response.fold(
      (l) => Left(l),
      (r) => Right(RemoveVehicleModel.fromMap(r)),
    );
  }

  @override
  Future<Either<IVehiclesFailures, AddVehicleModel>> addVehicle({
    required AddVehicleModel? addVehicleEntity,
  }) async {
    final response = await datasource.addVehicle(
      addVehicleEntity: addVehicleEntity,
    );
    return response.fold(
      (l) => Left(l),
      (r) => Right(AddVehicleModel.fromMap(r)),
    );
  }

  @override
  Future<Either<IVehiclesFailures, List<BrandVehicleModel>>>
      searchVehicleBrands() async {
    final result = await datasource.searchVehicleBrands();
    return result.fold((l) => Left(l), (brands) {
      return Right(
        brands
            .map<BrandVehicleModel>(
              (brand) => BrandVehicleModel.fromMap(brand),
            )
            .toList(),
      );
    });
  }

  @override
  Future<Either<IVehiclesFailures, List<ModelVehicleModel>>>
      searchVehicleModels({required int idBrand}) async {
    final result = await datasource.searchVehicleModels(idBrand: idBrand);

    return result.fold((l) => Left(l), (models) {
      return Right(
        models
            .map<ModelVehicleModel>(
              (model) => ModelVehicleModel.fromMap(model),
            )
            .toList(),
      );
    });
  }
}
