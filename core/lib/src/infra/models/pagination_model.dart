import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

import '../../domain/entities/pagination_entity.dart' show PaginationEntity;
import '../../domain/enums/pagination_type_enum.dart';

class PaginationModel extends PaginationEntity with EquatableMixin {
  PaginationModel({
    super.pageNumber,
    super.pageSize,
    super.orderBy,
    super.sortingOrder,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      pageNumber: map['page']?.toInt() ?? 1,
      pageSize: map['perPage']?.toInt() ?? 10,
      orderBy: map['orderBy'] ?? '',
      sortingOrder: sortingOrderTypeFromJson(map['sortingOrder']),
    );
  }

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source));

  factory PaginationModel.fromEntity(PaginationEntity entity) {
    return PaginationModel(
      sortingOrder: entity.sortingOrder,
      orderBy: entity.orderBy,
      pageNumber: entity.pageNumber,
      pageSize: entity.pageSize,
    );
  }

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'page': pageNumber,
      'perPage': pageSize,
      'sortingOrder': sortingOrder.toJson,
      if (orderBy.isNotEmpty) 'orderBy': orderBy,
    };
  }

  PaginationEntity get toEntity => this;

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        orderBy,
        sortingOrder,
      ];

  @override
  bool? get stringify => true;
}
