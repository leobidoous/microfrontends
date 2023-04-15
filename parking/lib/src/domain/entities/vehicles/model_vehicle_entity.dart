import '../../../infra/models/vehicles/brand_vehicle_model.dart';

class ModelVehicleEntity {
  const ModelVehicleEntity({
    this.id,
    this.name,
    this.vehicleBrand,
  });

  final int? id;
  final String? name;
  final BrandVehicleModel? vehicleBrand;
}
