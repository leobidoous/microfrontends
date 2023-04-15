import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/shopping_entity.dart';

class ShoppingModel extends ShoppingEntity with EquatableMixin {
  ShoppingModel({
    required super.id,
    required super.name,
    required super.type,
    required super.latitude,
    required super.longitude,
    required super.qrcode,
    required super.idAdministrator,
    required super.updatedAt,
    required super.createdAt,
    required super.address,
    required super.logoImage,
    required super.cnpj,
  });

  factory ShoppingModel.fromMap(Map<String, dynamic> map) {
    return ShoppingModel(
      id: map['id'] ?? 1,
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      latitude: map['latitude'] ?? '',
      longitude: map['longitude'] ?? '',
      qrcode: map['qrcode'] ?? '',
      idAdministrator: map['idAdministrator'] ?? 1,
      updatedAt: map['updatedAt'] ?? '',
      createdAt: map['createdAt'] ?? '',
      address: map['address'] ?? '',
      logoImage: map['logoImage'] ?? '',
      cnpj: map['cnpj'] ?? '',
    );
  }

  factory ShoppingModel.fromEntity(ShoppingEntity entity) {
    return ShoppingModel(
      id: entity.id,
      name: entity.name,
      type: entity.type,
      latitude: entity.latitude,
      longitude: entity.longitude,
      qrcode: entity.qrcode,
      idAdministrator: entity.idAdministrator,
      updatedAt: entity.updatedAt,
      createdAt: entity.createdAt,
      address: entity.address,
      logoImage: entity.logoImage,
      cnpj: entity.cnpj,
    );
  }

  factory ShoppingModel.fromJson(String source) =>
      ShoppingModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  ShoppingEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
      'qrcode': qrcode,
      'idAdministrator': idAdministrator,
      'updatedAt': updatedAt,
      'createdAt': createdAt,
      'address': address,
      'logoImage': logoImage,
      'cnpj': cnpj,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        latitude,
        longitude,
        qrcode,
        idAdministrator,
        updatedAt,
        createdAt,
        address,
        logoImage,
        cnpj,
      ];

  @override
  bool? get stringify => true;
}
