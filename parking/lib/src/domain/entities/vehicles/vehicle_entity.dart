import 'vehicle_specifications_entity.dart';

import 'vehicle_user_entity.dart';

class VeihicleEntity {
  VeihicleEntity({
    required this.id,
    required this.vehicleBrand,
    required this.vehicleModel,
    required this.user,
    required this.plate,
    required this.main,
    required this.createdAt,
  });

  final int? id;
  final VehicleEspecificationsEntity? vehicleBrand;
  final VehicleEspecificationsEntity? vehicleModel;
  final VehicleUserEntity? user;
  final String? plate;
  final bool? main;
  final DateTime? createdAt;
}
