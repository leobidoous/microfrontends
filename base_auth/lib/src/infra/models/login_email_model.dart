import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

import '../../domain/entities/login_email_entity.dart';

class LoginEmailModel extends LoginEmailEntity with EquatableMixin {
  LoginEmailModel({required super.email, required super.password});

  factory LoginEmailModel.fromMap(Map<String, dynamic> map) {
    return LoginEmailModel(
      email: map['email'] ?? '',
      password: map['senha'] ?? '',
    );
  }

  factory LoginEmailModel.fromEntity(LoginEmailEntity entity) {
    return LoginEmailModel(
      email: entity.email,
      password: entity.password,
    );
  }

  factory LoginEmailModel.fromJson(String source) =>
      LoginEmailModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'email': email,
      'senha': password,
    };
  }

  LoginEmailEntity get toEntity => this;

  @override
  List<Object?> get props => [email, password];

  @override
  bool? get stringify => true;
}
