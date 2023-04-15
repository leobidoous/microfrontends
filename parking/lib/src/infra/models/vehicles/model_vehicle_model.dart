import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicles/model_vehicle_entity.dart';
import 'brand_vehicle_model.dart';

class ModelVehicleModel extends ModelVehicleEntity with EquatableMixin {
  const ModelVehicleModel({
    super.id,
    super.name,
    super.vehicleBrand,
  });

  ModelVehicleModel copyWith({
    int? id,
    String? name,
    BrandVehicleModel? vehicleBrand,
  }) =>
      ModelVehicleModel(
        id: id ?? this.id,
        name: name ?? this.name,
        vehicleBrand: vehicleBrand ?? this.vehicleBrand,
      );

  factory ModelVehicleModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const ModelVehicleModel();
    return ModelVehicleModel(
      id: map['id'],
      name: map['name'],
      vehicleBrand: BrandVehicleModel.fromMap(map['VehicleBrand']),
    );
  }

  factory ModelVehicleModel.fromEntity(ModelVehicleEntity entity) {
    return ModelVehicleModel(
      id: entity.id,
      name: entity.name,
      vehicleBrand: entity.vehicleBrand,
    );
  }

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
      'VehicleBrand': vehicleBrand?.toJson,
    };
  }

  @override
  List<Object?> get props => [id, name, vehicleBrand];

  @override
  bool? get stringify => true;
}
