import '../enums/search_products_ordering_type.dart';

class SearchProductsFiltersEntity {
  String q;
  SearchProductsOrderingType sort;

  SearchProductsFiltersEntity({
    this.q = '',
    this.sort = SearchProductsOrderingType.relevance,
  });
}
