import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicles/add_vehicle_entity.dart';

class AddVehicleModel extends AddVehicleEntity with EquatableMixin {
  const AddVehicleModel({
    super.brandId,
    super.modelId,
    super.plate,
    super.main,
  });

  AddVehicleModel copyWith({
    int? brandId,
    int? modelId,
    String? plate,
    bool? main,
  }) =>
      AddVehicleModel(
        brandId: brandId ?? this.brandId,
        modelId: modelId ?? this.modelId,
        plate: plate ?? this.plate,
        main: main ?? this.main,
      );

  factory AddVehicleModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const AddVehicleModel();
    return AddVehicleModel(
      brandId: map['id_brand'],
      modelId: map['id_model'],
      plate: map['plate'],
      main: map['main'],
    );
  }

  factory AddVehicleModel.fromEntity(AddVehicleEntity entity) {
    return AddVehicleModel(
      brandId: entity.brandId,
      modelId: entity.modelId,
      plate: entity.plate,
      main: entity.main,
    );
  }

  factory AddVehicleModel.fromJson(String source) => AddVehicleModel.fromMap(
        json.decode(source),
      );

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'brandId': brandId,
      'modelId': modelId,
      'plate': plate,
      'main': main,
    };
  }

  @override
  List<Object?> get props => [
        brandId,
        modelId,
        plate,
        main,
      ];

  @override
  bool? get stringify => true;
}
