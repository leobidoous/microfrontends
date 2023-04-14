import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/order_item_entity.dart';

class OrderItemModel extends OrderItemEntity with EquatableMixin {
  OrderItemModel({
    required super.itemId,
    required super.quantity,
    required super.unitPriceCents,
    required super.externalId,
    required super.description,
    required super.imageUrl,
    required super.id,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      itemId: map['itemId'] ?? '',
      quantity: map['quantity'] ?? '',
      unitPriceCents: map['unitPriceCents'] ?? '',
      externalId: map['externalId'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      id: map['id'] ?? '',
    );
  }

  factory OrderItemModel.fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      itemId: entity.itemId,
      quantity: entity.quantity,
      unitPriceCents: entity.unitPriceCents,
      externalId: entity.externalId,
      description: entity.description,
      imageUrl: entity.imageUrl,
      id: entity.id,
    );
  }

  factory OrderItemModel.fromJson(String source) =>
      OrderItemModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  OrderItemEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'itemId': itemId,
      'quantity': quantity,
      'unitPriceCents': unitPriceCents,
      'externalId': externalId,
      'description': description,
      'imageUrl': imageUrl,
      'id': id,
    };
  }

  @override
  List<Object?> get props => [
        itemId,
        quantity,
        unitPriceCents,
        externalId,
        description,
        imageUrl,
        id,
      ];

  @override
  bool? get stringify => true;
}
