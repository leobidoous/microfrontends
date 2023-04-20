import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/store_address_entity.dart';

class StoreAddressModel extends StoreAddressEntity with EquatableMixin {
  StoreAddressModel({
    required super.city,
    required super.countryCode,
    required super.id,
    required super.line1,
    required super.line2,
    required super.line3,
    required super.neighborhood,
    required super.postalCode,
    required super.state,
  });

  factory StoreAddressModel.fromMap(Map<String, dynamic> map) {
    return StoreAddressModel(
      city: map['city'] ?? '',
      countryCode: map['countryCode'] ?? '',
      id: map['id'] ?? '',
      line1: map['line1'] ?? '',
      line2: map['line2'] ?? '',
      line3: map['line3'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      postalCode: map['postalCode'] ?? '',
      state: map['state'] ?? '',
    );
  }

  factory StoreAddressModel.fromEntity(StoreAddressEntity entity) {
    return StoreAddressModel(
      city: entity.city,
      countryCode: entity.countryCode,
      id: entity.id,
      line1: entity.line1,
      line2: entity.line2,
      line3: entity.line3,
      neighborhood: entity.neighborhood,
      postalCode: entity.postalCode,
      state: entity.state,
    );
  }

  StoreAddressModel copyWith({
    String? city,
    String? countryCode,
    String? id,
    String? line1,
    String? line2,
    String? line3,
    String? neighborhood,
    String? postalCode,
    String? state,
  }) {
    return StoreAddressModel(
      city: city ?? this.city,
      countryCode: countryCode ?? this.countryCode,
      id: id ?? this.id,
      line1: line1 ?? this.line1,
      line2: line2 ?? this.line2,
      line3: line3 ?? this.line3,
      neighborhood: neighborhood ?? this.neighborhood,
      postalCode: postalCode ?? this.postalCode,
      state: state ?? this.state,
    );
  }

  factory StoreAddressModel.fromJson(String source) =>
      StoreAddressModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StoreAddressEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'city': city,
      'countryCode': countryCode,
      'id': id,
      'line1': line1,
      'line2': line2,
      'line3': line3,
      'neighborhood': neighborhood,
      'postalCode': postalCode,
      'state': state,
    };
  }

  @override
  List<Object?> get props => [
        city,
        countryCode,
        id,
        line1,
        line2,
        line3,
        neighborhood,
        postalCode,
        state,
      ];

  @override
  bool? get stringify => true;
}
