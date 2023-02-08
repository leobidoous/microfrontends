import 'dart:convert' show json;

import 'package:equatable/equatable.dart' show EquatableMixin;

import '../../domain/entities/token_data_entity.dart';

class TokenDataModel extends TokenDataEntity with EquatableMixin {
  TokenDataModel({
    required super.refreshToken,
    required super.token,
  });

  factory TokenDataModel.fromMap(Map<String, dynamic> map) {
    return TokenDataModel(
      refreshToken: map['refreshToken'] ?? '',
      token: map['token'] ?? '',
    );
  }

  factory TokenDataModel.fromEntity(TokenDataEntity entity) {
    return TokenDataModel(
      refreshToken: entity.refreshToken,
      token: entity.token,
    );
  }

  factory TokenDataModel.fromJson(String source) =>
      TokenDataModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TokenDataEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'refreshToken': refreshToken,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [
        refreshToken,
        token,
      ];

  @override
  bool? get stringify => true;
}
