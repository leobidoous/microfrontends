import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/person_entity.dart';

class PersonModel extends PersonEntity with EquatableMixin {
  PersonModel({required super.name});

  factory PersonModel.fromMap(Map<String, dynamic> map) {
    return PersonModel(name: map['name'] ?? '');
  }

  factory PersonModel.fromEntity(PersonEntity entity) {
    return PersonModel(name: entity.name);
  }

  factory PersonModel.fromJson(String source) =>
      PersonModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  PersonEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {'name': name};
  }

  @override
  List<Object?> get props => [name];

  @override
  bool? get stringify => true;
}
