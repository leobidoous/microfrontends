import 'package:core/core.dart';

import '../../../domain/entities/vehicles/vehicle_entity.dart';
import '../../../domain/entities/vehicles/vehicle_specifications_entity.dart';
import '../../../domain/entities/vehicles/vehicle_user_entity.dart';
import 'vehicle_specification_model.dart';
import 'vehicle_user_model.dart';

class VehicleModel extends VeihicleEntity with EquatableMixin {
  VehicleModel({
    super.id,
    super.vehicleBrand,
    super.vehicleModel,
    super.user,
    super.plate,
    super.main,
    super.createdAt,
  });

  VehicleModel copyWith({
    int? id,
    VehicleEspecificationsEntity? vehicleBrand,
    VehicleEspecificationsEntity? vehicleModel,
    VehicleUserEntity? user,
    String? plate,
    bool? main,
    DateTime? createdAt,
  }) =>
      VehicleModel(
        id: id ?? this.id,
        vehicleBrand: vehicleBrand ?? this.vehicleBrand,
        vehicleModel: vehicleModel ?? this.vehicleModel,
        user: user ?? this.user,
        plate: plate ?? this.plate,
        main: main ?? this.main,
        createdAt: createdAt ?? this.createdAt,
      );

  factory VehicleModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return VehicleModel();

    return VehicleModel(
      id: map['id'],
      vehicleBrand: (map['User'] != null)
          ? VehicleEspecificationModel.fromMap(map['VehicleBrand'])
          : null,
      vehicleModel: (map['User'] != null)
          ? VehicleEspecificationModel.fromMap(map['VehicleModel'])
          : null,
      user:
          (map['User'] != null) ? VehicleUserModel.fromMap(map['User']) : null,
      plate: map['plate'],
      main: map['main'],
      createdAt: (map['createdAt'] != null)
          ? DateFormat.tryParseOrDateNow(map['createdAt'])
          : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        vehicleBrand,
        vehicleModel,
        user,
        plate,
        main,
        createdAt,
      ];
}
