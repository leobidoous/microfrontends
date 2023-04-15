import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../../domain/entities/gen_desk/faq_entity.dart';

class FAQModel extends FAQEntity with EquatableMixin {
  FAQModel({
    required super.title,
    super.subtitle,
    super.content,
  });

  factory FAQModel.fromMap(Map<String, dynamic> map) {
    return FAQModel(
      title: map['title'] ?? '',
      subtitle: map['subtitle'] ?? '',
      content: map['content'] ?? '',
    );
  }

  factory FAQModel.fromEntity(FAQEntity entity) {
    return FAQModel(
      title: entity.title,
      subtitle: entity.subtitle,
      content: entity.content,
    );
  }

  factory FAQModel.fromJson(String source) =>
      FAQModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  FAQEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'title': title,
      'subtitle': subtitle,
      'content': content,
    };
  }

  @override
  List<Object?> get props => [
        title,
        subtitle,
        content,
      ];

  @override
  bool? get stringify => true;
}
