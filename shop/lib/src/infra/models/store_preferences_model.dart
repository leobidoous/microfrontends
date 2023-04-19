import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/store_preferences_entity.dart';

class StorePreferencesModel extends StorePreferencesEntity with EquatableMixin {
  StorePreferencesModel({
    required super.allowInstallment,
    required super.allowMethods,
    required super.defaultMaxInstallments,
    required super.defaultPaymentMethods,
    required super.eatIn,
    required super.serviceCharge,
    required super.takeOut,
    required super.usingDelivery,
  });

  factory StorePreferencesModel.fromMap(Map<String, dynamic> map) {
    return StorePreferencesModel(
      allowInstallment: map['allowInstallment'] ?? false,
      allowMethods: map['allowMethods'] ?? false,
      defaultMaxInstallments: map['defaultMaxInstallments'] ?? 1,
      defaultPaymentMethods: map['defaultPaymentMethods'] ?? {},
      eatIn: map['eatIn'] ?? false,
      serviceCharge: map['serviceCharge'] ?? false,
      takeOut: map['takeOut'] ?? false,
      usingDelivery: map['usingDelivery'] ?? false,
    );
  }

  factory StorePreferencesModel.fromEntity(StorePreferencesEntity entity) {
    return StorePreferencesModel(
      allowInstallment: entity.allowInstallment,
      allowMethods: entity.allowMethods,
      defaultMaxInstallments: entity.defaultMaxInstallments,
      defaultPaymentMethods: entity.defaultPaymentMethods,
      eatIn: entity.eatIn,
      serviceCharge: entity.serviceCharge,
      takeOut: entity.takeOut,
      usingDelivery: entity.usingDelivery,
    );
  }

  StorePreferencesModel copyWith({
    bool? allowInstallment,
    bool? allowMethods,
    int? defaultMaxInstallments,
    Map<String, dynamic>? defaultPaymentMethods,
    bool? eatIn,
    bool? serviceCharge,
    bool? takeOut,
    bool? usingDelivery,
  }) {
    return StorePreferencesModel(
      allowInstallment: allowInstallment ?? this.allowInstallment,
      allowMethods: allowMethods ?? this.allowMethods,
      defaultMaxInstallments:
          defaultMaxInstallments ?? this.defaultMaxInstallments,
      defaultPaymentMethods:
          defaultPaymentMethods ?? this.defaultPaymentMethods,
      eatIn: eatIn ?? this.eatIn,
      serviceCharge: serviceCharge ?? this.serviceCharge,
      takeOut: takeOut ?? this.takeOut,
      usingDelivery: usingDelivery ?? this.usingDelivery,
    );
  }

  factory StorePreferencesModel.fromJson(String source) =>
      StorePreferencesModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StorePreferencesEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'allowInstallment': allowInstallment,
      'allowMethods': allowMethods,
      'defaultMaxInstallments': defaultMaxInstallments,
      'defaultPaymentMethods': defaultPaymentMethods,
      'eatIn': eatIn,
      'serviceCharge': serviceCharge,
      'takeOut': takeOut,
      'usingDelivery': usingDelivery,
    };
  }

  @override
  List<Object?> get props => [
        allowInstallment,
        allowMethods,
        defaultMaxInstallments,
        defaultPaymentMethods,
        eatIn,
        serviceCharge,
        takeOut,
        usingDelivery,
      ];

  @override
  bool? get stringify => true;
}
