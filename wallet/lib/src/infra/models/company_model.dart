import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/company_entity.dart';

class CompanyModel extends CompanyEntity with EquatableMixin {
  CompanyModel({
    required super.businessName,
    required super.tradeName,
  });
  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    return CompanyModel(
      businessName: map['businessName'] ?? '',
      tradeName: map['tradeName'] ?? '',
    );
  }

  factory CompanyModel.fromEntity(CompanyEntity entity) {
    return CompanyModel(
      businessName: entity.businessName,
      tradeName: entity.tradeName,
    );
  }

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  CompanyEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'businessName': businessName,
      'tradeName': tradeName,
    };
  }

  @override
  List<Object?> get props => [
        businessName,
        tradeName,
      ];

  @override
  bool? get stringify => true;
}
