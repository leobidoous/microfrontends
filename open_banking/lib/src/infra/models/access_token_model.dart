import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/access_token_entity.dart';

class AccessTokenModel extends AccessTokenEntity with EquatableMixin {

  AccessTokenModel({
    required super.access,
    required super.refresh,
  });

  factory AccessTokenModel.fromMap(Map<String, dynamic> map) {
     return AccessTokenModel(
      access: map['access'] ?? '', 
      refresh: map['refresh'] ?? '',
    );
  }

  factory AccessTokenModel.fromEntity(AccessTokenEntity entity) {
    return AccessTokenModel(
      access: entity.access,
      refresh: entity.refresh,
    );
  }

  factory AccessTokenModel.fromjson(String source) =>
    AccessTokenModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  AccessTokenModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'access': access,
      'refresh': refresh,
    };
  }
  
  @override
  List<Object?> get props => [
    access,
    refresh,
  ];

  @override
  bool? get stringify => true;
}