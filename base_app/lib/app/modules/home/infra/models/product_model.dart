import 'dart:convert';

import '../../domain/entities/product_entity.dart';

class ProductModel extends ProductEntity {
  ProductModel({
    required super.name,
    required super.image,
    required super.price,
    required super.oldPrice,
    required super.rate,
    required super.reviews,
    required super.freeShipping,
    required super.discount,
    required super.id,
    required super.colors,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
      'price': price,
      'oldPrice': oldPrice,
      'rate': rate,
      'reviews': reviews,
      'freeShipping': freeShipping,
      'discount': discount,
      'id': id,
      'colors': colors,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      oldPrice: map['oldPrice']?.toDouble(),
      rate: map['rate']?.toInt() ?? 0,
      reviews: map['reviews']?.toInt() ?? 0,
      freeShipping: map['freeShipping'] ?? false,
      discount: map['discount']?.toInt(),
      id: map['id'] ?? '',
      colors: map['colors']?.toInt() ?? 0,
    );
  }
  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      name: entity.name,
      image: entity.image,
      price: entity.price,
      oldPrice: entity.oldPrice,
      rate: entity.rate,
      reviews: entity.reviews,
      freeShipping: entity.freeShipping,
      discount: entity.discount,
      id: entity.id,
      colors: entity.colors,
    );
  }

  String toJson() => json.encode(toMap());
  ProductEntity toentity() => this;

  ProductEntity toEntity() => this;

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source));
}
