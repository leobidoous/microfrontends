
import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../../domain/repositories/get_cart_products_repository.dart';
import '../datasources/get_cart_products_datasource.dart';

class GetCartProductsRepository extends IGetCartProductsRepository {
  final IGetCartProductsDatasource datasource;

  GetCartProductsRepository({required this.datasource});

  @override
  Future<Either<Exception, List<ProductEntity>>> call() {
    return datasource();
  }
}