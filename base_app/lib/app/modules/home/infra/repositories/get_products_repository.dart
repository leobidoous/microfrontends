import 'package:dartz/dartz.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/search_products_filters_entity.dart';
import '../../domain/repositories/get_products_repository.dart';
import '../datasources/get_products_datasource.dart';

class GetProductsRepository extends IGetProductsRepository {
  final IGetProductsDatasource datasource;

  GetProductsRepository({required this.datasource});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required SearchProductsFiltersEntity params,
  }) {
    return datasource(params: params);
  }
}
