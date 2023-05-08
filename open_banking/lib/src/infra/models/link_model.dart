import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/link_entity.dart';

class LinkModel extends LinkEntity with EquatableMixin {

  LinkModel({
    required super.id,
    required super.status,
    required super.accessMode,
    required super.institution,
  });

  factory LinkModel.fromMap(Map<String, dynamic> map) {
    return LinkModel(
       id: map['id'] ?? '',
       status: map['status'] ?? '',
       accessMode: map['accessMode'] ?? '',
       institution: map['institution'] ?? '',
    );
  }

  factory LinkModel.fromEntity(LinkEntity entity) {
    return LinkModel(
       id: entity.id,
       status: entity.status,
       accessMode: entity.accessMode,
       institution: entity.institution,
    );
  }

  factory LinkModel.fromjson(String source) =>
  LinkModel.fromMap(json.decode(source));
 
  String get toJson => json.encode(toMap);

  LinkModel get topEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'status': status,
      'accessMode': accessMode,
      'institution': institution,
    };
  }

  @override
  List<Object?> get props => [
    id,
    status,
    accessMode,
    institution,
  ];

  @override
  bool? get stringify => true;


}