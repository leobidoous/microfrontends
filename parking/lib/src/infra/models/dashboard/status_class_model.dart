import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/dashboard/status_class_entity.dart';

class StatusClassModel extends StatusClassEntity with EquatableMixin {
  StatusClassModel({required super.status, required super.code});

  factory StatusClassModel.fromMap(Map<String, dynamic> map) {
    return StatusClassModel(
      status: map['status'] ?? '',
      code: map['cod'] ?? 0,
    );
  }

  factory StatusClassModel.fromEntity(StatusClassEntity entity) {
    return StatusClassModel(
      status: entity.status,
      code: entity.code,
    );
  }

  factory StatusClassModel.fromJson(String source) =>
      StatusClassModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StatusClassEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'status': status,
      'code': code,
    };
  }

  @override
  List<Object?> get props => [
        status,
        code,
      ];

  @override
  bool? get stringify => true;
}
