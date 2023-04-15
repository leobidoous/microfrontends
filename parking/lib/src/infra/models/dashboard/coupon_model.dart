import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/dashboard/coupon_entity.dart';

class CouponModel extends CouponEntity with EquatableMixin {
  CouponModel({
    required super.amount,
    required super.canGetFreeParking,
    required super.amountUntilFreeParking,
    required super.campaignValue,
    required super.hasUsedVoucher,
    required super.qtdCoupon,
    required super.customerCreation,
  });

  factory CouponModel.fromMap(Map<String, dynamic> map) {
    return CouponModel(
      canGetFreeParking: map['can_get_free_parking'] ?? false,
      amount: double.tryParse(map['amount']?.toString() ?? '') ?? 0.0,
      amountUntilFreeParking: double.tryParse(
            map['amount_until_free_parking']?.toString() ?? '',
          ) ??
          0.0,
      campaignValue:
          double.tryParse(map['campaign_value']?.toString() ?? '') ?? 0.0,
      hasUsedVoucher: map['has_used_vouche'] ?? false,
      qtdCoupon: map['qtd_coupon'] ?? 0,
      customerCreation: map['customer_creation'] ?? {},
    );
  }

  factory CouponModel.fromEntity(CouponEntity entity) {
    return CouponModel(
      amount: entity.amount,
      canGetFreeParking: entity.canGetFreeParking,
      amountUntilFreeParking: entity.amountUntilFreeParking,
      campaignValue: entity.campaignValue,
      hasUsedVoucher: entity.hasUsedVoucher,
      qtdCoupon: entity.qtdCoupon,
      customerCreation: entity.customerCreation,
    );
  }

  factory CouponModel.fromJson(String source) =>
      CouponModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  CouponEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'amount': amount,
      'can_get_free_parking': canGetFreeParking,
      'amount_until_free_parking': amountUntilFreeParking,
      'campaign_value': campaignValue,
      'has_used_vouche': hasUsedVoucher,
      'qtd_coupon': qtdCoupon,
      'customerCreation': customerCreation,
    };
  }

  @override
  List<Object?> get props => [
        amount,
        canGetFreeParking,
        amountUntilFreeParking,
        campaignValue,
        hasUsedVoucher,
        qtdCoupon,
        customerCreation,
      ];

  @override
  bool? get stringify => true;
}
