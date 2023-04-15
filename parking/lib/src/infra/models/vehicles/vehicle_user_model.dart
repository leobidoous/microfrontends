import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/vehicles/vehicle_user_entity.dart';

class VehicleUserModel extends VehicleUserEntity with EquatableMixin {
  VehicleUserModel({
    super.id,
    super.name,
    super.email,
    super.phone,
    super.cpf,
  });

  factory VehicleUserModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return VehicleUserModel();
    return VehicleUserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      cpf: map['cpf'],
    );
  }

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'cpf': cpf,
    };
  }

  factory VehicleUserModel.fromJson(String source) {
    return VehicleUserModel.fromMap(
      json.decode(source),
    );
  }

  String get toJson => json.encode(toMap);

  VehicleUserEntity get toEntity => this;

  @override
  List<Object?> get props => [id, name, email, phone, cpf];
}
