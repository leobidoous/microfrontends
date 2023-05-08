import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/credit_data_entity.dart';

class CreditDataModel extends CreditDataEntity with EquatableMixin {

  CreditDataModel({
    required super.collectedAt, 
    required super.creditLimit, 
    required super.cuttingDate, 
    required super.endDate,
    required super.interestRate,
    required super.lastPaymentDate,
    required super.lastPeriodBalance,
    required super.minimumPayment,
    required super.monthlyPayment,
    required super.nextPaymentDate,
    required super.noInterestPayment,
  });
  
  factory CreditDataModel.fromMap(Map<String, dynamic> map) {
     return CreditDataModel(
       collectedAt: DateFormat.tryParseOrDateNow(map['collectedAt']),
       creditLimit: map['creditLimit'] ?? 0,
       cuttingDate: map['cuttingDate'] ?? '',
       endDate: map['endDate'] ?? '',
       interestRate: map['interestRate'] ?? 0,
       lastPaymentDate: map['lastPaymentDate'] ?? '',
       lastPeriodBalance: map['lastPeriodBalance'] ?? '',
       minimumPayment: map['minimumPayment'] ?? 0,
       monthlyPayment: map['monthlyPayment'] ?? 0,
       nextPaymentDate: map['nextPaymentDate'] ?? '',
       noInterestPayment: map['noInterestPayment'] ?? '',
    );
  }

  factory CreditDataModel.fromEntity(CreditDataEntity entity) {
    return CreditDataModel(
       collectedAt: entity.collectedAt,
       creditLimit: entity.creditLimit,
       cuttingDate: entity.cuttingDate,
       endDate: entity.endDate,
       interestRate: entity.interestRate,
       lastPaymentDate: entity.lastPaymentDate,
       lastPeriodBalance: entity.lastPeriodBalance,
       minimumPayment: entity.minimumPayment,
       monthlyPayment: entity.monthlyPayment, 
       nextPaymentDate: entity.nextPaymentDate, 
       noInterestPayment: entity.noInterestPayment, 
    );
  }

  factory CreditDataModel.fromjson(String source) =>
    CreditDataModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  CreditDataModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'collectedAt': collectedAt,
      'creditLimit': creditLimit,
      'cuttingDate': cuttingDate,
      'endDate': endDate,
      'interestRate': interestRate,
      'lastPaymentDate': lastPaymentDate,
      'lastPeriodBalance': lastPeriodBalance,
      'minimumPayment': minimumPayment,
      'monthlyPayment': monthlyPayment, 
      'nextPaymentDate': nextPaymentDate, 
      'noInterestPayment': noInterestPayment, 
    };
  }

  @override
  List<Object?> get props => [
    collectedAt, 
    creditLimit, 
    cuttingDate, 
    endDate,
    interestRate,
    lastPaymentDate,
    lastPeriodBalance,
    minimumPayment,
    monthlyPayment,
    nextPaymentDate,
    noInterestPayment,
  ];

  @override
  bool? get stringify => true;

}