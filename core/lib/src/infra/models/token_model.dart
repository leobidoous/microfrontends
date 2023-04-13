import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/token_entity.dart';

class TokenModel extends TokenEntity with EquatableMixin {
  TokenModel({
    required super.accessToken,
    required super.customToken,
    required super.refreshToken,
    required super.expiresIn,
  });

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      accessToken: map['accessToken'] ?? '',
      customToken: map['customToken'] ?? '',
      refreshToken: map['refreshToken'] ?? '',
      expiresIn: map['expiresIn'] ?? '',
    );
  }

  factory TokenModel.fromEntity(TokenEntity entity) {
    return TokenModel(
      accessToken: entity.accessToken,
      customToken: entity.customToken,
      refreshToken: entity.refreshToken,
      expiresIn: entity.expiresIn,
    );
  }

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TokenEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'accessToken': accessToken,
      'customToken': customToken,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
    };
  }

  @override
  List<Object?> get props => [
        accessToken,
        customToken,
        refreshToken,
        expiresIn,
      ];

  @override
  bool? get stringify => true;
}
