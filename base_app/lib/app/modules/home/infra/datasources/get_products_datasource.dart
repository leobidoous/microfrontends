import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/search_products_filters_entity.dart';

abstract class IGetProductsDatasource {
  Future<Either<Exception, List<ProductEntity>>> call({
    required SearchProductsFiltersEntity params,
  });
}
