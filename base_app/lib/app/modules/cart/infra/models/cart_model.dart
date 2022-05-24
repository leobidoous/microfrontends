import 'dart:convert';

import '../../domain/entities/cart_entity.dart';

class CartModel extends CartEntity {
  CartModel({required super.id,  super.quantity = 1});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      id: map['id'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
    );
  }

  factory CartModel.fromEntity(CartEntity entity) {
    return CartModel(id: entity.id, quantity: entity.quantity);
  }

  String toJson() => json.encode(toMap());

  CartEntity toEntity() => this;

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));
}
