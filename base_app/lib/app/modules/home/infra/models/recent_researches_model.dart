import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/recent_researches_entity.dart';

class RecentResearchesModel extends RecentResearchesEntity with EquatableMixin {
  RecentResearchesModel({
    required super.term,
    required super.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'term': term,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory RecentResearchesModel.fromMap(Map<String, dynamic> map) {
    return RecentResearchesModel(
      term: map['term'] ?? '',
      createdAt: FormatDate.timestampToDate(map['createdAt']),
    );
  }

  factory RecentResearchesModel.fromEntity(RecentResearchesEntity entity) {
    return RecentResearchesModel(
      term: entity.term,
      createdAt: entity.createdAt,
    );
  }

  String toJson() => json.encode(toMap());

  RecentResearchesEntity toEntity() => this;

  factory RecentResearchesModel.fromJson(String source) =>
      RecentResearchesModel.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [term, createdAt];
}
