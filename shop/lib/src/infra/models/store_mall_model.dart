import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/store_mall_entity.dart';

class StoreMallModel extends StoreMallEntity with EquatableMixin {
  StoreMallModel({
    required super.id,
    required super.name,
    required super.shortName,
  });

  factory StoreMallModel.fromMap(Map<String, dynamic> map) {
    return StoreMallModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      shortName: map['shortName'] ?? '',
    );
  }

  factory StoreMallModel.fromEntity(StoreMallEntity entity) {
    return StoreMallModel(
      id: entity.id,
      name: entity.name,
      shortName: entity.shortName,
    );
  }

  StoreMallModel copyWith({
    String? id,
    String? name,
    String? shortName,
  }) {
    return StoreMallModel(
      id: id ?? this.id,
      name: name ?? this.name,
      shortName: shortName ?? this.shortName,
    );
  }

  factory StoreMallModel.fromJson(String source) =>
      StoreMallModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StoreMallEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'name': name,
      'shortName': shortName,
    };
  }

  @override
  List<Object?> get props => [
        id,
        name,
        shortName,
      ];

  @override
  bool? get stringify => true;
}
