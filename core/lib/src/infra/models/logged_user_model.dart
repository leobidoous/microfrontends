import 'dart:convert';

import '../../domain/entities/logged_user_entity.dart';

class LoggedUserModel extends LoggedUserEntity {
  LoggedUserModel(
      {required String name, required String email, String phone = ''})
      : super(name: name, email: email);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
    };
  }

  LoggedUserEntity toEntity() => this;
  // LoggedUserEntity toEntity() {
  //   return LoggedUserEntity(
  //     name: name,
  //     email: email,
  //     phone: phone,
  //   );
  // }

  factory LoggedUserModel.fromMap(Map<String, dynamic> map) {
    return LoggedUserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  factory LoggedUserModel.fromEntiy(LoggedUserEntity entity) {
    return LoggedUserModel(
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoggedUserModel.fromJson(String source) =>
      LoggedUserModel.fromMap(json.decode(source));
}
