import 'dart:convert';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/ticket/mall_entity.dart';

class MallModel extends MallEntity with EquatableMixin {
  const MallModel({super.name, super.id});

  factory MallModel.fromEntity(MallEntity entity) {
    return MallModel(name: entity.name, id: entity.id);
  }

  factory MallModel.fromJson(String source) =>
      MallModel.fromMap(json.decode(source));

  factory MallModel.fromMap(Map<String, dynamic> map) {
    return MallModel(
      id: map['id_mall'] ?? '',
      name: map['name'] ?? '',
    );
  }

  Map<String, dynamic> get toMap {
    return {'id_mall': id, 'name': name};
  }

  String get toJson => json.encode(toMap);

  MallEntity get toEntity => this;

  @override
  List<Object?> get props => [id, name];

  @override
  bool? get stringify => true;
}
