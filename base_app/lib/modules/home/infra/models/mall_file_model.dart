import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/mall_file_entity.dart';

class MallFileModel extends MallFileEntity with EquatableMixin {
  MallFileModel({
    required super.id,
    required super.url,
    required super.path,
  });

  factory MallFileModel.fromMap(Map<String, dynamic> map) {
    return MallFileModel(
      id: map['id'] ?? 0,
      url: map['url'] ?? '',
      path: map['path'] ?? '',
    );
  }

  factory MallFileModel.fromEntity(MallFileEntity entity) {
    return MallFileModel(
      id: entity.id,
      url: entity.url,
      path: entity.path,
    );
  }

  factory MallFileModel.fromJson(String source) =>
      MallFileModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  MallFileEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'url': url,
      'path': path,
    };
  }

  @override
  List<Object?> get props => [
        id,
        url,
        path,
      ];

  @override
  bool? get stringify => true;
}
