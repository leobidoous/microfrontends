import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({
    required super.name,
    required super.cpf,
    required super.phone,
    required super.password,
    required super.customerId,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      cpf: map['cpf'] ?? '',
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
      customerId: map['customer_id'] ?? '',
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      cpf: entity.cpf,
      phone: entity.phone,
      password: entity.password,
      customerId: entity.customerId,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  UserEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'name': name,
      'cpf': cpf,
      'phone': phone,
      'password': password,
      'customer_id': customerId,
    };
  }

  @override
  List<Object?> get props => [
        name,
        cpf,
        phone,
        password,
        customerId,
      ];

  @override
  bool? get stringify => true;
}
