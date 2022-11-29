import 'dart:convert';

import '../../domain/entities/token_entity.dart';

class TokenModel extends TokenEntity {
  TokenModel({
    super.expireOffSet,
    required super.accessToken,
    required super.idToken,
    required super.tokenType,
    required super.refreshToken,
    required super.issueTimeStamp,
    required super.expireTimeStamp,
    required super.expiresIn,
  });

  Map<String, dynamic> toMap() {
    return {
      'expire_offSet': expireOffSet,
      'access_token': accessToken,
      'id_token': idToken,
      'token_type': tokenType,
      'refresh_token': refreshToken,
      'issue_imeStamp': issueTimeStamp.millisecondsSinceEpoch,
      'expire_timestamp': expireTimeStamp.millisecondsSinceEpoch,
      'expires_in': expiresIn,
    };
  }

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      expireOffSet: map['expire_offSet']?.toInt() ?? 0,
      accessToken: map['access_token'] ?? '',
      idToken: map['id_token'] ?? '',
      tokenType: map['token_type'] ?? '',
      refreshToken: map['refresh_token'] ?? '',
      issueTimeStamp: DateTime.now().toUtc(),
      expireTimeStamp: DateTime.fromMillisecondsSinceEpoch(
        map['expire_timestamp'] ?? 0,
      ),
      expiresIn: map['expires_in'] is int
          ? map['expires_in']
          : int.tryParse(map['expires_in'].toString()) ?? 60,
    );
  }

  factory TokenModel.fromEntity(TokenEntity entity) {
    return TokenModel(
      expireOffSet: entity.expireOffSet,
      accessToken: entity.accessToken,
      idToken: entity.idToken,
      tokenType: entity.tokenType,
      refreshToken: entity.refreshToken,
      issueTimeStamp: entity.issueTimeStamp,
      expireTimeStamp: entity.expireTimeStamp,
      expiresIn: entity.expiresIn,
    );
  }

  String toJson() => json.encode(toMap());

  TokenEntity toEntity() => this;

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source));
}
