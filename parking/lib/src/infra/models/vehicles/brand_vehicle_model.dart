import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicles/brand_vehicle_entity.dart';

class BrandVehicleModel extends BrandVehicleEntity with EquatableMixin {
  const BrandVehicleModel({
    super.id,
    super.name,
  });

  BrandVehicleModel copyWith({
    int? id,
    String? name,
  }) =>
      BrandVehicleModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory BrandVehicleModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const BrandVehicleModel();
    return BrandVehicleModel(
      id: map['id'],
      name: map['name'],
    );
  }

  factory BrandVehicleModel.fromEntity(BrandVehicleEntity entity) {
    return BrandVehicleModel(
      id: entity.id,
      name: entity.name,
    );
  }

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
