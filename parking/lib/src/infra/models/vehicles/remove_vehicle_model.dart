import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicles/remove_vehicle_entity.dart';

class RemoveVehicleModel extends RemoveVehicleEntity with EquatableMixin {
  const RemoveVehicleModel({
    super.id,
    super.plate,
    super.main,
    super.createdAt,
    super.updatedAt,
    super.deletedAt,
    super.idModel,
    super.idBrand,
    super.idUser,
  });

  RemoveVehicleModel copyWith({
    int? id,
    String? plate,
    bool? main,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    int? idModel,
    int? idBrand,
    int? idUser,
  }) =>
      RemoveVehicleModel(
        id: id ?? this.id,
        plate: plate ?? this.plate,
        main: main ?? this.main,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        idModel: idModel ?? this.idModel,
        idBrand: idBrand ?? this.idBrand,
        idUser: idUser ?? this.idUser,
      );

  factory RemoveVehicleModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return const RemoveVehicleModel();
    return RemoveVehicleModel(
      id: map['id'],
      plate: map['plate'],
      main: map['main'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      deletedAt: map['deletedAt'],
      idModel: map['idModel'],
      idBrand: map['idBrand'],
      idUser: map['idUser'],
    );
  }

  factory RemoveVehicleModel.fromJson(String source) =>
      RemoveVehicleModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'plate': plate,
      'main': main,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deletedAt': deletedAt,
      'idModel': idModel,
      'idBrand': idBrand,
      'idUser': idUser,
    };
  }

  @override
  List<Object?> get props => [
        id,
        plate,
        main,
        createdAt,
        updatedAt,
        deletedAt,
        idModel,
        idBrand,
        idUser,
      ];

  @override
  bool? get stringify => true;
}
