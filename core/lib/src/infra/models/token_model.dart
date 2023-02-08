import 'dart:convert' show json;

import 'package:equatable/equatable.dart' show EquatableMixin;

import '../../domain/entities/token_data_entity.dart';
import '../../domain/entities/token_entity.dart';
import 'token_data_model.dart';

class TokenModel extends TokenEntity with EquatableMixin {
  TokenModel({
    required super.clientId,
    required super.tokenData,
  });

  factory TokenModel.fromMap(Map<String, dynamic> map) {
    return TokenModel(
      clientId: map['clienteId'] ?? '',
      tokenData: map['tokenData'] != null
          ? TokenDataModel.fromMap(map['tokenData'])
          : TokenDataEntity(token: '', refreshToken: ''),
    );
  }

  factory TokenModel.fromEntity(TokenEntity entity) {
    return TokenModel(
      clientId: entity.clientId,
      tokenData: entity.tokenData,
    );
  }

  factory TokenModel.fromJson(String source) =>
      TokenModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  TokenEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'clienteId': clientId,
      'tokenData': TokenDataModel.fromEntity(tokenData).toMap,
    };
  }

  @override
  List<Object?> get props => [
        clientId,
        tokenData,
      ];

  @override
  bool? get stringify => true;
}
