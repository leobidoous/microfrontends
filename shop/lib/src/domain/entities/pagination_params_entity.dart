import 'package:equatable/equatable.dart';

import '../enum/sorting_order_method.dart';

class PaginationParamsEntity extends Equatable {
  const PaginationParamsEntity({
    this.orderBy,
    this.page,
    this.perPage,
    this.sortingOrder,
  });

  final String? orderBy;
  final int? page;
  final int? perPage;
  final SortingOrderMethod? sortingOrder; //ASC or DESC

  PaginationParamsEntity copyWith({
    String? orderBy,
    int? page,
    int? perPage,
    SortingOrderMethod? sortingOrder,
  }) =>
      PaginationParamsEntity(
        orderBy: orderBy ?? this.orderBy,
        page: page ?? this.page,
        perPage: perPage ?? this.perPage,
        sortingOrder: sortingOrder ?? this.sortingOrder,
      );

  factory PaginationParamsEntity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const PaginationParamsEntity();
    return PaginationParamsEntity(
      orderBy: json['orderBy'],
      page: json['page'],
      perPage: json['perPage'],
      sortingOrder: sortingOrderMethodFromJson(json['sortingOrder']),
    );
  }

  Map<String, dynamic> toJson() => {
        'orderBy': orderBy,
        'page': page,
        'perPage': perPage,
        'sortingOrder': SortingOrderMethodExt(sortingOrder!).toJson,
      };

  @override
  List<Object?> get props => [
        orderBy,
        page,
        perPage,
        sortingOrder,
      ];
}
