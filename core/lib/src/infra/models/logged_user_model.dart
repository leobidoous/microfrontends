import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/logged_user_entity.dart';
import 'token_model.dart';

class LoggedUserModel extends LoggedUserEntity with EquatableMixin {
  LoggedUserModel({
    super.businessPhones,
    required super.displayName,
    required super.givenName,
    required super.jobTitle,
    required super.mail,
    required super.mobilePhone,
    required super.officeLocation,
    required super.preferredLanguage,
    required super.surname,
    required super.userPrincipalName,
    required super.id,
    required super.graphToken,
    required super.sharepointToken,
  });

  Map<String, dynamic> toMap() {
    return {
      'businessPhones': businessPhones,
      'displayName': displayName,
      'givenName': givenName,
      'jobTitle': jobTitle,
      'mail': mail,
      'mobilePhone': mobilePhone,
      'officeLocation': officeLocation,
      'preferredLanguage': preferredLanguage,
      'surname': surname,
      'userPrincipalName': userPrincipalName,
      'id': id,
      'graphToken': TokenModel.fromEntity(graphToken).toMap(),
      'sharepointToken': TokenModel.fromEntity(sharepointToken).toMap(),
    };
  }

  LoggedUserEntity toEntity() => this;

  factory LoggedUserModel.fromMap(Map<String, dynamic> map) {
    return LoggedUserModel(
      businessPhones: List<String>.from(map['businessPhones']),
      displayName: map['displayName'] ?? '',
      givenName: map['givenName'] ?? '',
      jobTitle: map['jobTitle'] ?? '',
      mail: map['mail'] ?? '',
      mobilePhone: map['mobilePhone'] ?? '',
      officeLocation: map['officeLocation'] ?? '',
      preferredLanguage: map['preferredLanguage'] ?? '',
      surname: map['surname'] ?? '',
      userPrincipalName: map['userPrincipalName'] ?? '',
      id: map['id'] ?? '',
      graphToken: TokenModel.fromMap(map['graphToken'] ?? {}),
      sharepointToken: TokenModel.fromMap(map['sharepointToken'] ?? {}),
    );
  }

  factory LoggedUserModel.fromEntiy(LoggedUserEntity entity) {
    return LoggedUserModel(
      displayName: entity.displayName,
      givenName: entity.givenName,
      jobTitle: entity.jobTitle,
      mail: entity.mail,
      mobilePhone: entity.mobilePhone,
      officeLocation: entity.officeLocation,
      preferredLanguage: entity.preferredLanguage,
      surname: entity.surname,
      userPrincipalName: entity.userPrincipalName,
      id: entity.id,
      graphToken: entity.graphToken,
      sharepointToken: entity.sharepointToken,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoggedUserModel.fromJson(String source) =>
      LoggedUserModel.fromMap(json.decode(source));

  @override
  List<Object?> get props => [
        displayName,
        givenName,
        jobTitle,
        mail,
        mobilePhone,
        officeLocation,
        preferredLanguage,
        surname,
        userPrincipalName,
        id,
        graphToken,
        sharepointToken,
      ];

  @override
  bool? get stringify => true;
}
