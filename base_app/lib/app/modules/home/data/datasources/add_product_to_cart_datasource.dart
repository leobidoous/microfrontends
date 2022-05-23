import 'package:dartz/dartz.dart';

import '../../domain/entities/product_entity.dart';
import '../../infra/datasources/add_product_to_cart_datasource.dart';

class AddProductToCartDatasource extends IAddProductToCartDatasource {
  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  }) {
    // TODO: implement call
    throw UnimplementedError();
  }
}
