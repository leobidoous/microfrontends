import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/search_products_filters_entity.dart';
import '../../infra/datasources/get_products_datasource.dart';
import '../../infra/models/product_model.dart';
import '../../infra/models/search_products_filters_model.dart';

class GetProductsDatasource extends IGetProductsDatasource {
  final IHttpDriver httpDriver;

  GetProductsDatasource({required this.httpDriver});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required SearchProductsFiltersEntity params,
  }) async {
    final response = await httpDriver.get(
      '/search',
      queryParameters: SearchProductsFiltersModel.fromEntity(params).toMap(),
    );
    return response.fold(
      (l) => Left(Exception('[${l.statusCode}] ${l.data}')),
      (r) {
        return Right(
          (r.data as List)
              .map((e) => ProductModel.fromMap(e).toEntity())
              .toList(),
        );
      },
    );
  }
}
