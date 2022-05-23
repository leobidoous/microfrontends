import 'package:core/core.dart';

import '../entities/product_entity.dart';
import '../repositories/remove_product_from_cart_repository.dart';

abstract class IRemoveProductFromCartUsecase {
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  });
}

class RemoveProductFromCartUsecase extends IRemoveProductFromCartUsecase {
  final IRemoveProductFromCartRepository repository;

  RemoveProductFromCartUsecase({required this.repository});

  @override
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  }) {
    return repository(product: product);
  }
}
