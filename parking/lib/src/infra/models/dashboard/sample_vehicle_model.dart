import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/dashboard/sample_vehicle_entity.dart';

class SampleVehicleModel extends SampleVehicleEntity with EquatableMixin {
  const SampleVehicleModel({
    super.brand,
    super.idVehicle,
    super.model,
  });

  factory SampleVehicleModel.fromMap(Map<String, dynamic> map) {
    return SampleVehicleModel(
      brand: map['brand'],
      model: map['model'],
      idVehicle: map['id_vehicle'],
    );
  }
  factory SampleVehicleModel.fromEntity(SampleVehicleEntity entity) {
    return SampleVehicleModel(
      brand: entity.brand,
      model: entity.model,
      idVehicle: entity.idVehicle,
    );
  }
  factory SampleVehicleModel.fromJson(String source) =>
      SampleVehicleModel.fromMap(json.decode(source));

  Map<String, dynamic> get toMap {
    return {
      'brand': brand,
      'model': model,
      'id_vehicle': idVehicle,
    };
  }

  String get toJson => json.encode(toMap);

  SampleVehicleEntity get toEntity => this;

  @override
  List<Object?> get props => [brand, idVehicle, model];
}
