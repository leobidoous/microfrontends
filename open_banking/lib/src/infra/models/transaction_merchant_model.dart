import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction_merchant_entity.dart';

class TransactionMerchantModel 
  extends TransactionMerchantEntity with EquatableMixin {

  TransactionMerchantModel({
    required super.logo,
    required super.merchantName,
    required super.website,
  });

  factory TransactionMerchantModel.fromMap(Map<String, dynamic> map) {
    return TransactionMerchantModel(
      logo: map['logo'] ?? '',
      merchantName: map['merchantName'] ?? '',
      website: map['website'] ?? '',
    );
  }

  factory TransactionMerchantModel.fromEntity(TransactionMerchantEntity entity) {
    return TransactionMerchantModel(
       logo: entity.logo,
       merchantName: entity.merchantName,
       website: entity.website,
    );
  }

  factory TransactionMerchantModel.fromjson(String source) =>
  TransactionMerchantModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  TransactionMerchantModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'logo': logo,
      'merchantName': merchantName,
      'website': website,
    };
  }

  @override
  List<Object?> get props => [
    logo,
    merchantName,
    website,
  ];

  @override
  bool? get stringify => true;


}