import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/dashboard/shopping_name_entity.dart';

class ShoppingNameModel extends ShoppingNameEntity with EquatableMixin {
  ShoppingNameModel({
    required super.name,
  });

  factory ShoppingNameModel.fromMap(Map<String, dynamic> map) {
    return ShoppingNameModel(
      name: map['name'],
    );
  }

  factory ShoppingNameModel.fromEntity(ShoppingNameEntity entity) {
    return ShoppingNameModel(
      name: entity.name,
    );
  }

  factory ShoppingNameModel.fromJson(String source) =>
      ShoppingNameModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  ShoppingNameEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'name': name,
    };
  }

  @override
  List<Object?> get props => [
    name,
  ];

  @override
  bool? get stringify => true;
}
