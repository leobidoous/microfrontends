enum SearchProductsOrderingType {
  lowestPrice,
  highestPrice,
  highestDiscount,
  relevance,
}

extension SearchProductsOrderingTypeExt on SearchProductsOrderingType {
  String get toMap {
    switch (this) {
      case SearchProductsOrderingType.lowestPrice:
        return 'lowestPrice';
      case SearchProductsOrderingType.highestPrice:
        return 'highestPrice';
      case SearchProductsOrderingType.highestDiscount:
        return 'highestDiscount';
      case SearchProductsOrderingType.relevance:
        return 'relevance';
    }
  }
}

SearchProductsOrderingType searchProductsOrderingTypeFromMap(String? type) {
  switch (type) {
    case 'lowestPrice':
      return SearchProductsOrderingType.lowestPrice;
    case 'highestPrice':
      return SearchProductsOrderingType.highestPrice;
    case 'highestDiscount':
      return SearchProductsOrderingType.highestDiscount;
    case 'relevance':
      return SearchProductsOrderingType.relevance;
    default:
      return SearchProductsOrderingType.relevance;
  }
}
