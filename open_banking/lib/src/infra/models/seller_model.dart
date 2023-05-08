import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/seller_entity.dart';

class SellerModel extends SellerEntity with EquatableMixin {

  SellerModel({required super.id});

  factory SellerModel.fromMap(Map<String, dynamic> map) {
    return SellerModel(
       id: map['id'] ?? '',
    );
  }

  factory SellerModel.fromEntity(SellerEntity entity) {
    return SellerModel(
       id: entity.id,
    );
  }

  factory SellerModel.fromjson(String source) =>
  SellerModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  SellerModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
    };
  }

  @override
  List<Object?> get props => [
    id,
  ];

  @override
  bool? get stringify => true;

}