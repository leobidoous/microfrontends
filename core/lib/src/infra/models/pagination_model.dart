import 'dart:convert';

import '../../domain/entities/pagination_entity.dart';

class PaginationModel extends PaginationEntity {
  PaginationModel({
    super.count = 0,
    super.next,
    super.previous,
    super.offset = 0,
    super.limit = 10,
  });

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'offset': offset,
      'limit': limit,
    };
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      count: map['count']?.toInt() ?? 0,
      next: map['next'],
      previous: map['previous'],
      offset: map['offset']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source));
}
