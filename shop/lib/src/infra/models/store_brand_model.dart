import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/store_brand_entity.dart';

class StoreBrandModel extends StoreBrandEntity with EquatableMixin {
  StoreBrandModel({
    required super.id,
    required super.logo,
    required super.name,
  });

  factory StoreBrandModel.fromMap(Map<String, dynamic> map) {
    return StoreBrandModel(
      id: map['id'] ?? '',
      logo: map['logo'] ?? '',
      name: map['name'] ?? '',
    );
  }

  factory StoreBrandModel.fromEntity(StoreBrandEntity entity) {
    return StoreBrandModel(
      id: entity.id,
      logo: entity.logo,
      name: entity.name,
    );
  }

  StoreBrandModel copyWith({
    String? id,
    String? logo,
    String? name,
  }) {
    return StoreBrandModel(
      id: id ?? this.id,
      logo: logo ?? this.logo,
      name: name ?? this.name,
    );
  }

  factory StoreBrandModel.fromJson(String source) =>
      StoreBrandModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StoreBrandEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'logo': logo,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        logo,
        name,
      ];

  @override
  bool? get stringify => true;
}
