import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/billing_address_entity.dart';

class BillingAddressModel extends BillingAddressEntity with EquatableMixin {
  BillingAddressModel({
    required super.city,
    required super.postalCode,
    required super.countryCode,
    required super.neighborhood,
    required super.line1,
    required super.line2,
    required super.line3,
    required super.state,
  });

  factory BillingAddressModel.fromMap(Map<String, dynamic> map) {
    return BillingAddressModel(
      city: map['city'] ?? '',
      line2: map['line2'] ?? '',
      postalCode: map['postalCode'] ?? '',
      countryCode: map['countryCode'] ?? '',
      neighborhood: map['neighborhood'] ?? '',
      line1: map['line1'] ?? '',
      line3: map['line3'] ?? '',
      state: map['state'] ?? '',
    );
  }

  factory BillingAddressModel.fromEntity(BillingAddressEntity entity) {
    return BillingAddressModel(
      city: entity.city,
      line2: entity.line2,
      postalCode: entity.postalCode,
      countryCode: entity.countryCode,
      neighborhood: entity.neighborhood,
      line1: entity.line1,
      line3: entity.line3,
      state: entity.state,
    );
  }

  factory BillingAddressModel.fromJson(String source) =>
      BillingAddressModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  BillingAddressEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'city': city,
      'line2': line2,
      'postalCode': postalCode,
      'countryCode': countryCode,
      'neighborhood': neighborhood,
      'line1': line1,
      'line3': line3,
      'state': state,
    };
  }

  @override
  List<Object?> get props => [
        city,
        line2,
        postalCode,
        countryCode,
        neighborhood,
        line1,
        line3,
        state,
      ];

  @override
  bool? get stringify => true;
}
