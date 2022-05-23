import 'package:dartz/dartz.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/add_product_to_cart_repository.dart';
import '../datasources/add_product_to_cart_datasource.dart';

class AddProductToCartRepository extends IAddProductToCartRepository {
  final IAddProductToCartDatasource datasource;

  AddProductToCartRepository({required this.datasource});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  }) {
    return datasource(product: product);
  }
}
