import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicles/vehicle_specifications_entity.dart';

class VehicleEspecificationModel extends VehicleEspecificationsEntity
    with EquatableMixin {
  VehicleEspecificationModel({super.id, super.name});

  factory VehicleEspecificationModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return VehicleEspecificationModel();
    return VehicleEspecificationModel(id: map['id'], name: map['name']);
  }

  factory VehicleEspecificationModel.fromEntity(
    VehicleEspecificationsEntity entity,
  ) {
    return VehicleEspecificationModel(
      id: entity.id,
      name: entity.name,
    );
  }

  VehicleEspecificationsEntity get toEntity => this;

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {'id': id, 'name': name};
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
