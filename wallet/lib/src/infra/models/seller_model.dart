import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/seller_entity.dart';
import 'company_model.dart';
import 'person_model.dart';

class SellerModel extends SellerEntity with EquatableMixin {
  SellerModel({
    required super.company,
    required super.displayName,
    required super.person,
    required super.id,
    required super.cnpj,
    required super.cpf,
  });

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
      company: CompanyModel.fromMap(map['company'] ?? {}),
      displayName: map['displayName'] ?? '',
      person: PersonModel.fromMap(map['person'] ?? {}),
      id: map['id'] ?? '',
      cnpj: map['cnpj'] ?? '',
      cpf: map['cpf'] ?? '',
    );
  }

  factory SellerModel.fromEntity(SellerEntity entity) {
    return SellerModel(
      company: entity.company,
      displayName: entity.displayName,
      person: entity.person,
      id: entity.id,
      cnpj: entity.cnpj,
      cpf: entity.cpf,
    );
  }

  factory SellerModel.fromJson(String source) =>
      SellerModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  SellerEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'company': CompanyModel.fromEntity(company).toMap,
      'displayName': displayName,
      'person': PersonModel.fromEntity(person).toMap,
      'id': id,
      'cnpj': cnpj,
      'cpf': cpf,
    };
  }

  @override
  List<Object?> get props => [
        company,
        displayName,
        person,
        id,
        cnpj,
        cpf,
      ];

  @override
  bool? get stringify => true;
}
