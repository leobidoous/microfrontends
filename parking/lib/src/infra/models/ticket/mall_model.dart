import 'dart:convert';

import 'package:core/core.dart';

import '../../../domain/entities/ticket/mall_entity.dart';

class MallModel extends MallEntity with EquatableMixin {
  MallModel({super.name});

  factory MallModel.fromEntity(MallEntity entity) {
    return MallModel(name: entity.name);
  }

  factory MallModel.fromJson(String source) =>
      MallModel.fromMap(json.decode(source));

  factory MallModel.fromMap(Map<String, dynamic> map) {
    return MallModel(
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> get toMap {
    return {'name': name};
  }

  String get toJson => json.encode(toMap);

  MallEntity get toEntity => this;

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => true;
}
