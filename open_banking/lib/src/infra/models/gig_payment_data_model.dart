import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/gig_payment_data_entity.dart';

class GigPaymentDataModel extends GigPaymentDataEntity with EquatableMixin {
  
  GigPaymentDataModel({
    required super.balance, 
    required super.name, 
    required super.percentage, 
    required super.type,
  });  

  factory GigPaymentDataModel.fromMap(Map<String, dynamic> map) {
   return GigPaymentDataModel(
     balance: map['balance'] ?? '',
     name: map['name'] ?? '',
     percentage: map['percentage'] ?? '',
     type: map['type'] ?? '',
   );
 }

  factory GigPaymentDataModel.fromEntity(GigPaymentDataEntity entity) {
    return GigPaymentDataModel(
      balance: entity.balance,
      name: entity.name,
      percentage: entity.percentage,
      type: entity.type,
    );
  }

  factory GigPaymentDataModel.fromjson(String source) =>
  GigPaymentDataModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  GigPaymentDataModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'balance': balance,
      'name': name,
      'percentage': percentage,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
    balance,
    name,
    percentage,
    type,
  ];

  @override
  bool? get stringify => true;

}