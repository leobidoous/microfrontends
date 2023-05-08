import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/customer_entity.dart';


class CustomerModel extends CustomerEntity with EquatableMixin {

  CustomerModel({
    required super.id,
    required super.cpf,
    required super.name,
  });

  factory CustomerModel.fromMap(Map<String, dynamic> map) {
    return CustomerModel(
       id: map['id'] ?? '',
       cpf: map['cpf'] ?? '',
       name: map['name'] ?? '',
    );
  }

  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
       id: entity.id,
       cpf: entity.cpf,
       name: entity.name,
    );
  }

  factory CustomerModel.fromjson(String source) =>
  CustomerModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  CustomerModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'cpf': cpf,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [
    id,
    cpf,
    name,
  ];

  @override
  bool? get stringify => true;

}