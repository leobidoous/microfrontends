import 'dart:convert' show json;

import 'package:equatable/equatable.dart';

import '../../domain/entities/pagination_entity.dart' show PaginationEntity;

class PaginationModel extends PaginationEntity with EquatableMixin {
  PaginationModel({
    super.pageNumber,
    super.pageSize,
    super.totalRecords,
    super.pagesRemaining,
  });

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      pageNumber: map['pageNumber']?.toInt() ?? 1,
      pageSize: map['pageSize']?.toInt() ?? 10,
      totalRecords: map['totalRecords']?.toInt() ?? 0,
      pagesRemaining: map['pagesRemaining']?.toInt() ?? 0,
    );
  }

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source));

  factory PaginationModel.fromEntity(PaginationEntity entity) {
    return PaginationModel(
      pagesRemaining: entity.pagesRemaining,
      totalRecords: entity.pagesRemaining,
      pageNumber: entity.pageNumber,
      pageSize: entity.pageSize,
    );
  }

  String get toJson => json.encode(toMap);

  Map<String, dynamic> get toMap {
    return {
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalRecords': totalRecords,
      'pagesRemaining': pagesRemaining,
    };
  }

  PaginationEntity get toEntity => this;

  @override
  List<Object?> get props => [
        pageNumber,
        pageSize,
        totalRecords,
        pagesRemaining,
      ];

  @override
  bool? get stringify => true;
}
