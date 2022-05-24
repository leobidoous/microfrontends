import 'dart:convert';

import '../../domain/entities/cart_entity.dart';
import '../../domain/entities/order_entity.dart';
import 'cart_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({super.items = const []});

  Map<String, dynamic> toMap() {
    return {
      'items': items.map((x) => CartModel.fromEntity(x).toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      items: List<CartEntity>.from(
        map['items']?.map((x) => CartModel.fromMap(x).toEntity()),
      ),
    );
  }

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(items: entity.items);
  }

  String toJson() => json.encode(toMap());
  OrderEntity toEntity() => this;

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));
}
