import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/claims_entity.dart';

class ClaimsModel extends ClaimsEntity with EquatableMixin {
  ClaimsModel({
    required super.customerId,
    required super.phoneNumber,
    required super.picture,
    required super.userId,
    required super.aud,
    required super.exp,
    required super.iat,
    required super.iss,
    required super.sub,
    required super.name,
    required super.email,
    required super.emailVerified,
    required super.sellerId,
    required super.marketplaceId,
    required super.authTime,
  });

  factory ClaimsModel.fromMap(Map<String, dynamic> map) {
    return ClaimsModel(
      customerId: map['customerId'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      picture: map['picture'] ?? '',
      userId: map['userId'] ?? '',
      aud: map['aud'] ?? '',
      exp: int.tryParse(map['exp'].toString()) ?? 0,
      iat: int.tryParse(map['iat'].toString()) ?? 0,
      iss: map['iss'] ?? '',
      sub: map['sub'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      emailVerified: map['emailVerified'] ?? false,
      sellerId: map['sellerId'] ?? '',
      marketplaceId: map['marketplaceId'] ?? '',
      authTime: int.tryParse(map['authTime'].toString()) ?? 0,
    );
  }

  factory ClaimsModel.fromEntity(ClaimsEntity entity) {
    return ClaimsModel(
      customerId: entity.customerId,
      phoneNumber: entity.phoneNumber,
      picture: entity.picture,
      userId: entity.userId,
      aud: entity.aud,
      exp: entity.exp,
      iat: entity.iat,
      iss: entity.iss,
      sub: entity.sub,
      name: entity.name,
      email: entity.email,
      emailVerified: entity.emailVerified,
      sellerId: entity.sellerId,
      marketplaceId: entity.marketplaceId,
      authTime: entity.authTime,
    );
  }

  factory ClaimsModel.fromJson(String source) =>
      ClaimsModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  ClaimsEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'customerId': customerId,
      'phoneNumber': phoneNumber,
      'picture': picture,
      'userId': userId,
      'aud': aud,
      'exp': exp,
      'iat': iat,
      'iss': iss,
      'sub': sub,
      'name': name,
      'email': email,
      'emailVerified': emailVerified,
      'sellerId': sellerId,
      'marketplaceId': marketplaceId,
      'authTime': authTime,
    };
  }

  @override
  List<Object?> get props => [
        customerId,
        phoneNumber,
        picture,
        userId,
        aud,
        exp,
        iat,
        iss,
        sub,
        name,
        email,
        emailVerified,
        sellerId,
        marketplaceId,
        authTime,
      ];

  @override
  bool? get stringify => true;
}
