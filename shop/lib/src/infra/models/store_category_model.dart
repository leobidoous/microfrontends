import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/store_category_entity.dart';

class StoreCategoryModel extends StoreCategoryEntity with EquatableMixin {
  StoreCategoryModel({
    required super.id,
    required super.name,
  });

  factory StoreCategoryModel.fromMap(Map<String, dynamic> map) {
    return StoreCategoryModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
    );
  }

  factory StoreCategoryModel.fromEntity(StoreCategoryEntity entity) {
    return StoreCategoryModel(
      id: entity.id,
      name: entity.name,
    );
  }

  StoreCategoryModel copyWith({
    String? id,
    String? name,
  }) {
    return StoreCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  factory StoreCategoryModel.fromJson(String source) =>
      StoreCategoryModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StoreCategoryEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  bool? get stringify => true;
}
