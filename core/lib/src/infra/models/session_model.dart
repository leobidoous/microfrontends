import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/claims_entity.dart';
import '../../domain/entities/customer_entity.dart';
import '../../domain/entities/external_user_entity.dart';
import '../../domain/entities/session_entity.dart';
import '../../domain/entities/token_entity.dart';
import '../../domain/entities/user_entity.dart';
import 'claims_model.dart';
import 'customer_model.dart';
import 'external_user_model.dart';
import 'token_model.dart';
import 'user_model.dart';

class SessionModel extends SessionEntity with EquatableMixin {
  SessionModel({
    required super.externalUser,
    required super.customer,
    required super.claims,
    required super.token,
    required super.user,
  });

  factory SessionModel.fromMap(Map<String, dynamic> map) {
    return SessionModel(
      externalUser: ExternalUserModel.fromMap(map['externalUser'] ?? {}),
      customer: CustomerModel.fromMap(map['customer'] ?? {}),
      claims: ClaimsModel.fromMap(map['claims'] ?? {}),
      token: TokenModel.fromMap(map['token'] ?? {}),
      user: UserModel.fromMap(map['user'] ?? {}),
    );
  }

  factory SessionModel.fromEntity(SessionEntity entity) {
    return SessionModel(
      externalUser: entity.externalUser,
      customer: entity.customer,
      claims: entity.claims,
      token: entity.token,
      user: entity.user,
    );
  }

  factory SessionModel.fromJson(String source) =>
      SessionModel.fromMap(json.decode(source));

  SessionModel copyWith({
    ExternalUserEntity? externalUser,
    CustomerEntity? customer,
    ClaimsEntity? claims,
    TokenEntity? token,
    UserEntity? user,
  }) {
    return SessionModel(
      externalUser: externalUser ?? this.externalUser,
      customer: customer ?? this.customer,
      claims: claims ?? this.claims,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }

  String get toJson => json.encode(toMap);

  SessionEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'externalUser': ExternalUserModel.fromEntity(externalUser).toMap,
      'customer': CustomerModel.fromEntity(customer).toMap,
      'claims': ClaimsModel.fromEntity(claims).toMap,
      'token': TokenModel.fromEntity(token).toMap,
      'user': UserModel.fromEntity(user).toMap,
    };
  }

  @override
  List<Object?> get props => [
        externalUser,
        customer,
        claims,
        token,
        user,
      ];

  @override
  bool? get stringify => true;
}
