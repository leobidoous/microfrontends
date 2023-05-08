import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/account_entity.dart';
import '../models/account_institution_model.dart';
import '../models/balance_model.dart';
import '../models/credit_data_model.dart';
import '../models/customer_model.dart' as customer;
import '../models/gig_payment_data_model.dart';
import '../models/link_model.dart';
import '../models/loan_data_model.dart';
import '../models/seller_model.dart';

class AccountModel extends AccountEntity with EquatableMixin {

  AccountModel({
    required super.balance,
    required super.balanceType,
    required super.bankProductId,
    required super.category,
    required super.collectedAt,
    required super.createdAt,
    required super.creditData,
    required super.currency,
    required super.customer, 
    required super.externalId, 
    required super.gigPaymentData, 
    required super.id, 
    required super.institution, 
    required super.internalIdentification, 
    required super.lastAccessedAt, 
    required super.link, 
    required super.loanData, 
    required super.name, 
    required super.number, 
    required super.publicIdentificationName, 
    required super.publicIdentificationValue, 
    required super.seller, 
    required super.type,
  });

  factory AccountModel.fromMap(Map<String, dynamic> map) {
     return AccountModel(
       balance: BalanceModel.fromMap(
         Map<String, dynamic>.from(map['balance'] ?? {}),
       ),
       balanceType: map['balanceType'] ?? '',
       bankProductId: map['bankProductId'] ?? '',
       category: map['category'] ?? '',
       collectedAt: DateFormat.tryParseOrDateNow(map['collectedAt']),
       createdAt: DateFormat.tryParseOrDateNow(map['createdAt']),
       creditData: CreditDataModel.fromMap(
         Map<String, dynamic>.from(map['creditData'] ?? {}),
       ),
       currency: map['currency'] ?? '',
       customer: customer.CustomerModel.fromMap(
         Map<String, dynamic>.from(map['customer'] ?? {}),
       ),
       externalId: map['externalId'] ?? '',
       gigPaymentData: GigPaymentDataModel.fromMap(
         Map<String, dynamic>.from(map['gigPaymentData'] ?? {}),
       ),
       id: map['id'] ?? '',
       institution: AccountInstitutionModel.fromMap(
         Map<String, dynamic>.from(map['institution'] ?? {}),
       ),
       internalIdentification: map['internalIdentification'] ?? '',
       lastAccessedAt: DateFormat.tryParseOrDateNow(map['lastAccessedAt']),
       link: LinkModel.fromMap(
         Map<String, dynamic>.from(map['link'] ?? {}),
       ),
       loanData: LoanDataModel.fromMap(
         Map<String, dynamic>.from(map['loanData'] ?? {}),
       ),
       name: map['name'] ?? '',
       number: map['number'] ?? '',
       publicIdentificationName: map['publicIdentificationName'] ?? '',
       publicIdentificationValue: map['publicIdentificationValue'] ?? '',
       seller: SellerModel.fromMap(
         Map<String, dynamic>.from(map['seller'] ?? {}),
       ),
       type: map['type'] ?? '',
    );
  }

  factory AccountModel.fromEntity(AccountEntity entity) {
    return AccountModel(
       balance: entity.balance,
       balanceType: entity.balanceType,
       bankProductId: entity.bankProductId,
       category: entity.category,
       collectedAt: entity.collectedAt,
       createdAt: entity.createdAt,
       creditData: entity.creditData,
       currency: entity.currency,
       customer: entity.customer, 
       externalId: entity.externalId, 
       gigPaymentData: entity.gigPaymentData, 
       id: entity.id, 
       institution: entity.institution, 
       internalIdentification: entity.internalIdentification, 
       lastAccessedAt: entity.lastAccessedAt, 
       link: entity.link, 
       loanData: entity.loanData, 
       name: entity.name, 
       number: entity.number, 
       publicIdentificationName: entity.publicIdentificationName, 
       publicIdentificationValue: entity.publicIdentificationValue, 
       seller: entity.seller, 
       type: entity.type,
    );
  }

  factory AccountModel.fromjson(String source) =>
  AccountModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  AccountModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'balance': balance,
      'balanceType': balanceType,
      'bankProductId': bankProductId,
      'category': category,
      'collectedAt': collectedAt,
      'createdAt': createdAt,
      'creditData': creditData,
      'currency': currency,
      'customer': customer.CustomerModel, 
      'externalId': externalId,
      'gigPaymentData': gigPaymentData,
      'id': id,
      'institution': institution,
      'internalIdentification': internalIdentification,
      'lastAccessedAt': lastAccessedAt,
      'link': link,
      'loanData': loanData,
      'name': name,
      'number': number,
      'publicIdentificationName': publicIdentificationName,
      'publicIdentificationValue': publicIdentificationValue,
      'seller': seller,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
    balance,
    balanceType,
    bankProductId,
    category,
    collectedAt,
    createdAt,
    creditData,
    currency,
    customer.CustomerModel, 
    externalId, 
    gigPaymentData, 
    id, 
    institution, 
    internalIdentification, 
    lastAccessedAt, 
    link, 
    loanData, 
    name, 
    number, 
    publicIdentificationName, 
    publicIdentificationValue, 
    seller, 
    type,
  ];

  @override
  bool? get stringify => true;

}