import 'package:core/core.dart';

import '../enums/credit_card_type.dart';

class CreditCardEntity {
  final String id;
  final String externalId;
  final String last4;
  final DateTime insertedAt;
  final bool blocked;
  final CreditCardType brand;
  final DateTime updatedAt;
  final bool verified;
  final bool inUse;
  final bool isFavorite;
  final String cardColor;
  String marketplaceId;
  String customerId;
  String cardNumber;
  String expirationMonth;
  String holderName;
  BillingAddressEntity billingAddress;
  String token;
  String expirationYear;
  String cpfOrCnpj;
  String securityCode;

  CreditCardEntity({
    required this.id,
    required this.externalId,
    required this.cardNumber,
    required this.last4,
    required this.marketplaceId,
    required this.insertedAt,
    required this.expirationMonth,
    required this.blocked,
    required this.brand,
    required this.updatedAt,
    required this.holderName,
    required this.customerId,
    required this.billingAddress,
    required this.verified,
    required this.token,
    required this.inUse,
    required this.isFavorite,
    required this.expirationYear,
    required this.cardColor,
    required this.cpfOrCnpj,
    required this.securityCode,
  });
}
