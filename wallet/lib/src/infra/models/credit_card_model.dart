import 'dart:convert';

import 'package:core/core.dart' hide BillingAddressModel;

import '../../domain/entities/billing_address_entity.dart' ;
import '../../domain/entities/credit_card_entity.dart';
import '../../domain/enums/credit_card_type.dart';
import 'billing_address_model.dart';

class CreditCardModel extends CreditCardEntity with EquatableMixin {
  CreditCardModel({
    required super.id,
    required super.externalId,
    required super.last4,
    required super.marketplaceId,
    required super.insertedAt,
    required super.expirationMonth,
    required super.blocked,
    required super.brand,
    required super.updatedAt,
    required super.holderName,
    required super.customerId,
    required super.billingAddress,
    required super.verified,
    required super.token,
    required super.inUse,
    required super.isFavorite,
    required super.expirationYear,
    required super.cardColor,
    required super.cpfOrCnpj,
    required super.securityCode,
    required super.cardNumber,
  });

  factory CreditCardModel.fromMap(Map<String, dynamic> map) {
    return CreditCardModel(
      id: map['id'] ?? '',
      cardNumber: map['cardNumber'] ?? '',
      externalId: map['externalId'] ?? '',
      last4: map['last4'] ?? '',
      marketplaceId: map['marketplaceId'] ?? '',
      insertedAt: DateFormat.tryParseOrDateNow(map['insertedAt']),
      expirationMonth: map['expirationMonth'] ?? '',
      blocked: map['blocked'] ?? false,
      brand: creditCardTypeFromJson(map['brand']),
      updatedAt: DateFormat.tryParseOrDateNow(map['updatedAt']),
      holderName: map['holderName'] ?? '',
      customerId: map['customerId'] ?? '',
      billingAddress: BillingAddressModel.fromMap(
        Map<String, dynamic>.from(map['billingAddress'] ?? {}),
      ),
      verified: map['verified'] ?? false,
      token: map['token'] ?? '',
      inUse: map['inUse'] ?? false,
      isFavorite: map['default'] ?? false,
      expirationYear: map['expirationYear'] ?? '',
      cardColor: map['cardColor'] ?? '',
      securityCode: map['securityCode'] ?? '',
      cpfOrCnpj: map['cpfOrCnpj'] ?? '',
    );
  }

  factory CreditCardModel.fromEntity(CreditCardEntity entity) {
    return CreditCardModel(
      id: entity.id,
      cardNumber: entity.cardNumber,
      externalId: entity.externalId,
      last4: entity.last4,
      marketplaceId: entity.marketplaceId,
      insertedAt: entity.insertedAt,
      expirationMonth: entity.expirationMonth,
      blocked: entity.blocked,
      brand: entity.brand,
      updatedAt: entity.updatedAt,
      holderName: entity.holderName,
      customerId: entity.customerId,
      billingAddress: entity.billingAddress,
      verified: entity.verified,
      token: entity.token,
      inUse: entity.inUse,
      isFavorite: entity.isFavorite,
      expirationYear: entity.expirationYear,
      cardColor: entity.cardColor,
      cpfOrCnpj: entity.cpfOrCnpj,
      securityCode: entity.securityCode,
    );
  }

  CreditCardModel copyWith({
    String? id,
    String? externalId,
    String? cardNumber,
    String? last4,
    String? marketplaceId,
    DateTime? insertedAt,
    String? expirationMonth,
    bool? blocked,
    CreditCardType? brand,
    DateTime? updatedAt,
    String? holderName,
    String? customerId,
    BillingAddressEntity? billingAddress,
    bool? verified,
    String? token,
    bool? inUse,
    bool? isFavorite,
    String? expirationYear,
    String? cardColor,
    String? cpfOrCnpj,
    String? securityCode,
  }) {
    return CreditCardModel(
      id: id ?? this.id,
      cardNumber: cardNumber ?? this.cardNumber,
      externalId: externalId ?? this.externalId,
      last4: last4 ?? this.last4,
      marketplaceId: marketplaceId ?? this.marketplaceId,
      insertedAt: insertedAt ?? this.insertedAt,
      expirationMonth: expirationMonth ?? this.expirationMonth,
      blocked: blocked ?? this.blocked,
      brand: brand ?? this.brand,
      updatedAt: updatedAt ?? this.updatedAt,
      holderName: holderName ?? this.holderName,
      customerId: customerId ?? this.customerId,
      billingAddress: billingAddress ?? this.billingAddress,
      verified: verified ?? this.verified,
      token: token ?? this.token,
      inUse: inUse ?? this.inUse,
      isFavorite: isFavorite ?? this.isFavorite,
      expirationYear: expirationYear ?? this.expirationYear,
      cardColor: cardColor ?? this.cardColor,
      cpfOrCnpj: cpfOrCnpj ?? this.cpfOrCnpj,
      securityCode: securityCode ?? this.securityCode,
    );
  }

  factory CreditCardModel.fromJson(String source) =>
      CreditCardModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  CreditCardEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'customerId': customerId,
      'expirationMonth': expirationMonth,
      'expirationYear': expirationYear,
      'holderName': holderName,
      'securityCode': securityCode,
      'token': token,
      'default': isFavorite,
      // TODO: removido por hora, pois o graphql nao suporta o endereco
      // 'cpf': cpfOrCnpj,
      // 'billingAddress': BillingAddressModel.fromEntity(billingAddress).toMap,
    };
  }

  @override
  List<Object?> get props => [
        id,
        externalId,
        last4,
        cardNumber,
        marketplaceId,
        insertedAt,
        expirationMonth,
        blocked,
        brand,
        updatedAt,
        holderName,
        customerId,
        billingAddress,
        verified,
        token,
        inUse,
        isFavorite,
        expirationYear,
        cardColor,
        cpfOrCnpj,
        securityCode,
      ];

  @override
  bool? get stringify => true;
}
