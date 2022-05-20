import 'package:core/core.dart';

import '../entities/product_entity.dart';
import '../entities/search_products_filters_entity.dart';
import '../repositories/get_products_repository.dart';

abstract class IGetProductsUsecase {
  Future<Either<Exception, List<ProductEntity>>> call({
    required SearchProductsFiltersEntity params,
  });
}

class GetProductsUsecase extends IGetProductsUsecase {
  final IGetProductsRepository repository;

  GetProductsUsecase({required this.repository});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required SearchProductsFiltersEntity params,
  }) async {
    if (params.q.isEmpty) {
      return Left(Exception('O parâmetro de busca não pode ser vazio'));
    }
    return repository(params: params);
  }
}
