import 'dart:convert';

import '../../domain/entities/search_products_filters_entity.dart';
import '../../domain/enums/search_products_ordering_type.dart';

class SearchProductsFiltersModel extends SearchProductsFiltersEntity {
  SearchProductsFiltersModel({required super.q, required super.sort});

  Map<String, dynamic> toMap() {
    return {'q': q, 'sort': sort.toMap};
  }

  factory SearchProductsFiltersModel.fromMap(Map<String, dynamic> map) {
    return SearchProductsFiltersModel(
      q: map['q'] ?? '',
      sort: searchProductsOrderingTypeFromMap(map['sort']),
    );
  }

  factory SearchProductsFiltersModel.fromEntity(
      SearchProductsFiltersEntity entity) {
    return SearchProductsFiltersModel(q: entity.q, sort: entity.sort);
  }

  String toJson() => json.encode(toMap());

  SearchProductsFiltersEntity toEntity() => this;

  factory SearchProductsFiltersModel.fromJson(String source) =>
      SearchProductsFiltersModel.fromMap(json.decode(source));
}
