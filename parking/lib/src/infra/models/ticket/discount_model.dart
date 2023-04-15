import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/ticket/discount_entity.dart';

class DiscountModel extends DiscountEntity with EquatableMixin {
  DiscountModel({
    required super.id,
    required super.name,
    required super.percentOfDiscount,
    required super.hasDescont,
  });

  factory DiscountModel.fromMap(Map<String, dynamic> map) {
    return DiscountModel(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      percentOfDiscount: (map['percent_of_decont'] != null)
          ? (map['percent_of_decont'] as num).toDouble()
          : 0.0,
      hasDescont: map['hasDescont'] ?? false,
    );
  }

  factory DiscountModel.fromEntity(DiscountEntity entity) {
    return DiscountModel(
      id: entity.id,
      name: entity.name,
      percentOfDiscount: entity.percentOfDiscount,
      hasDescont: entity.hasDescont,
    );
  }

  factory DiscountModel.fromJson(String source) =>
      DiscountModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  DiscountEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
      'percent_of_decont': percentOfDiscount,
      'hasDescont': hasDescont,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        percentOfDiscount,
        hasDescont,
      ];

  @override
  bool? get stringify => true;
}
