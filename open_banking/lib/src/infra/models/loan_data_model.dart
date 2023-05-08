import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/loan_data_entity.dart';

class LoanDataModel extends LoanDataEntity with EquatableMixin {

  LoanDataModel({
    required super.balanceType, 
    required super.bankProductId, 
    required super.category, 
    required super.collectedAt, 
    required super.createdAt, 
    required super.currency, 
    required super.externalId, 
    required super.internalIdentification, 
    required super.lastAccessedAt, 
    required super.name, 
    required super.number, 
    required super.publicIdentificationName, 
    required super.publicIdentificationValue, 
    required super.type,
  });

  factory LoanDataModel.fromMap(Map<String, dynamic> map) {
     return LoanDataModel(
      balanceType: map['balanceType'] ?? '',
      bankProductId: map['bankProductId'] ?? '',
      category: map['category'] ?? '',
      collectedAt: map['collectedAt'] ?? '',
      createdAt: map['createdAt'] ?? '',
      currency: map['currency'] ?? '',
      externalId: map['externalId'] ?? '',
      internalIdentification: map['internalIdentification'] ?? '',
      lastAccessedAt: map['lastAccessedAt'] ?? '',
      name: map['name'] ?? '',
      number: map['number'] ?? '',
      publicIdentificationName: map['publicIdentificationName'] ?? '',
      publicIdentificationValue: map['publicIdentificationValue'] ?? '',
      type: map['type'] ?? '',
    );
  }

  factory LoanDataModel.fromEntity(LoanDataEntity entity) {
    return LoanDataModel(
       balanceType: entity.balanceType,
       bankProductId: entity.bankProductId,
       category: entity.category,
       collectedAt: entity.collectedAt,
       createdAt: entity.createdAt,
       currency: entity.currency,
       externalId: entity.externalId, 
       internalIdentification: entity.internalIdentification, 
       lastAccessedAt: entity.lastAccessedAt, 
       name: entity.name, 
       number: entity.number, 
       publicIdentificationName: entity.publicIdentificationName, 
       publicIdentificationValue: entity.publicIdentificationValue, 
       type: entity.type,
    );
  }

  factory LoanDataModel.fromjson(String source) =>
  LoanDataModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  LoanDataModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'balanceType': balanceType,
      'bankProductId': bankProductId,
      'category': category,
      'collectedAt': collectedAt,
      'createdAt': createdAt,
      'currency': currency,
      'externalId': externalId,
      'internalIdentification': internalIdentification,
      'lastAccessedAt': lastAccessedAt,
      'name': name,
      'number': number,
      'publicIdentificationName': publicIdentificationName,
      'publicIdentificationValue': publicIdentificationValue,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
    balanceType,
    bankProductId,
    category,
    collectedAt,
    createdAt,
    currency,
    externalId, 
    internalIdentification, 
    lastAccessedAt, 
    name, 
    number, 
    publicIdentificationName, 
    publicIdentificationValue, 
    type,
  ];

  @override
  bool? get stringify => true;

}