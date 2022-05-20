import 'package:core/core.dart';

import '../entities/product_entity.dart';
import '../entities/search_products_filters_entity.dart';

abstract class IGetProductsRepository {
  Future<Either<Exception, List<ProductEntity>>> call({
    required SearchProductsFiltersEntity params,
  });
}
