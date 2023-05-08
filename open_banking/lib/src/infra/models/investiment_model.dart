import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/investiment_entity.dart';
import 'link_model.dart';

class InvestimentModel extends InvestimentEntity with EquatableMixin {

  InvestimentModel({
    required super.averageAcquisitionPrice,
    required super.balanceGross,
    required super.balanceNet,
    required super.currency,
    required super.id,
    required super.link,
    required super.name,
    required super.openDate,
    required super.price,
    required super.profit,
    required super.quantity,
    required super.subtype,
    required super.type,
  });

   factory InvestimentModel.fromMap(Map<String, dynamic> map) {
    return InvestimentModel(
      averageAcquisitionPrice: map['averageAcquisitionPrice'] ?? '',
      balanceGross: map['balanceGross'] ?? '',
      balanceNet: map['balanceNet'] ?? '',
      currency: map['currency'] ?? '',
      id: map['id'] ?? '',
      link: LinkModel.fromMap(
        Map<String, dynamic>.from(map['link'] ?? {}),
      ),
      name: map['name'] ?? '',
      openDate: map['openDate'] ?? '',
      price: map['price'] ?? '',
      profit: map['profit'] ?? '',
      quantity: map['quantity'] ?? '',
      subtype: map['subtype'] ?? '',
      type: map['type'] ?? '',
    );
  }

  factory InvestimentModel.fromEntity(InvestimentEntity entity) {
    return InvestimentModel(
      averageAcquisitionPrice: entity.averageAcquisitionPrice,
      balanceGross: entity.balanceGross,
      balanceNet: entity.balanceNet,
      currency: entity.currency,
      id: entity.id,
      link: entity.link,
      name: entity.name,
      openDate: entity.openDate,
      price: entity.price,
      profit: entity.profit,
      quantity: entity.quantity,
      subtype: entity.subtype,
      type: entity.type,
    );
  }

  factory InvestimentModel.fromjson(String source) =>
  InvestimentModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  InvestimentModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'averageAcquisitionPrice': averageAcquisitionPrice,
      'balanceGross': balanceGross,
      'balanceNet': balanceNet,
      'currency': currency,
      'id': id,
      'link': link,
      'name': name,
      'openDate': openDate,
      'price': price,
      'profit': profit,
      'quantity': quantity,
      'subtype': subtype,
      'type': type,
    };
  }

  @override
  List<Object?> get props => [
    averageAcquisitionPrice,
    balanceGross,
    balanceNet,
    currency,
    id,
    link,
    name,
    openDate,
    price,
    profit,
    quantity,
    subtype,
    type,
  ];

  @override
  bool? get stringify => true;

}