import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/external_user_entity.dart';

class ExternalUserModel extends ExternalUserEntity with EquatableMixin {
  ExternalUserModel({
    required super.name,
    required super.token,
    required super.externalId,
  });

  factory ExternalUserModel.fromMap(Map<String, dynamic> map) {
    return ExternalUserModel(
      name: map['name'] ?? '',
      token: map['token'] ?? '',
      externalId: map['external_id'] ?? '',
    );
  }

  factory ExternalUserModel.fromEntity(ExternalUserEntity entity) {
    return ExternalUserModel(
      name: entity.name,
      token: entity.token,
      externalId: entity.externalId,
    );
  }

  factory ExternalUserModel.fromJson(String source) =>
      ExternalUserModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  ExternalUserEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'name': name,
      'token': token,
      'external_id': externalId,
    };
  }

  @override
  List<Object?> get props => [
        name,
        token,
        externalId,
      ];

  @override
  bool? get stringify => true;
}
