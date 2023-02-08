import 'dart:convert' show json;

import 'package:equatable/equatable.dart' show EquatableMixin;

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity with EquatableMixin {
  UserModel({
    required super.name,
    required super.cpf,
    required super.email,
    required super.phone,
    required super.birth,
    required super.id,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['nome'] ?? '',
      cpf: map['cpf'] ?? '',
      email: map['email'] ?? '',
      phone: map['telefone'] ?? '',
      birth: DateTime.tryParse(map['dataNascimento']) ?? DateTime.now(),
      id: map['id'] ?? '',
      status: map['status'] ?? '',
      createdAt: DateTime.tryParse(map['dataCriacao']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(map['dataAlteracao']) ?? DateTime.now(),
    );
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      name: entity.name,
      cpf: entity.cpf,
      email: entity.email,
      phone: entity.phone,
      birth: entity.birth,
      id: entity.id,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  UserEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'nome': name,
      'cpf': cpf,
      'email': email,
      'telefone': phone,
      'dataNascimento': birth.toIso8601String(),
      'id': id,
      'status': status,
      'dataCriacao': createdAt.toIso8601String(),
      'dataAlteracao': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        name,
        cpf,
        email,
        phone,
        birth,
        id,
        status,
        createdAt,
        updatedAt,
      ];

  @override
  bool? get stringify => true;
}
