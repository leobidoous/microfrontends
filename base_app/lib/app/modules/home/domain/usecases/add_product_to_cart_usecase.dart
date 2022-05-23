import 'package:core/core.dart';

import '../entities/product_entity.dart';
import '../repositories/add_product_to_cart_repository.dart';

abstract class IAddProductToCartUsecase {
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  });
}

class AddProductToCartUsecase extends IAddProductToCartUsecase {
  final IAddProductToCartRepository repository;

  AddProductToCartUsecase({required this.repository});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  }) {
    return repository(product: product);
  }
}
