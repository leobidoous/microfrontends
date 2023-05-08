import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/Institution_entity.dart';

class InstitutionModel extends InstitutionEntity with EquatableMixin {

  InstitutionModel({
    required super.code,
    required super.countryCode,
    required super.countryCodes,
    required super.displayName,
    required super.iconLogo,
    required super.id,
    required super.logo,
    required super.name,
    required super.primaryColor,
    required super.resources,
    required super.status,
    required super.textLogo,
    required super.type,
    required super.website,
  });

  factory InstitutionModel.fromMap(Map<String, dynamic> map) {
     return InstitutionModel(
      code: map['code'] ?? '', 
      countryCode: map['countryCode'] ?? '',
      countryCodes: map['countryCodes'] ?? '',
      displayName: map['displayName'] ?? '',
      iconLogo: map['iconLogo'] ?? '',
      id: map['id'] ?? '',
      logo: map['logo'] ?? '',
      name: map['name'] ?? '',
      primaryColor: map['primaryColor'] ?? '',
      resources: map['resources'] ?? '',
      status: map['status'] ?? '',
      textLogo: map['textLogo'] ?? '',
      type: map['type'] ?? '',
      website: map['website'] ?? '',
    );
  }

  factory InstitutionModel.fromEntity(InstitutionEntity entity) {
    return InstitutionModel(
      code: entity.code,
      countryCode: entity.countryCode,
      countryCodes: entity.countryCodes,
      displayName: entity.displayName,
      iconLogo: entity.iconLogo,
      id: entity.id,
      logo: entity.logo,
      name: entity.name,
      primaryColor: entity.primaryColor,
      resources: entity.resources,
      status: entity.status,
      textLogo: entity.textLogo,
      type: entity.type,
      website: entity.website,
    );
  }


  factory InstitutionModel.fromjson(String source) =>
    InstitutionModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  InstitutionModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'code': code,
      'countryCode': countryCode,
      'countryCodes': countryCodes,
      'displayName': displayName,
      'iconLogo': iconLogo,
      'id': id,
      'logo': logo,
      'name': name,
      'primaryColor': primaryColor,
      'resources': resources,
      'status': status,
      'textLogo': textLogo,
      'type': type,
      'website': website,
    };
  }
  
  @override
  List<Object?> get props => [
     code,
     countryCode,
     countryCodes,
     displayName,
     iconLogo,
     id,
     logo,
     name,
     primaryColor,
     resources,
     status,
     textLogo,
     type,
     website,
  ];

  @override
  bool? get stringify => true;

}