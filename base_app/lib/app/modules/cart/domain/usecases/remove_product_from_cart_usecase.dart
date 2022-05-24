import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../repositories/remove_product_from_cart_repository.dart';

abstract class IRemoveProductFromCartUsecase {
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  });
  Future<Either<Exception, Unit>> clean();
}

class RemoveProductFromCartUsecase extends IRemoveProductFromCartUsecase {
  final IRemoveProductFromCartRepository repository;

  RemoveProductFromCartUsecase({required this.repository});

  @override
  Future<Either<Exception, Unit>> call({required ProductEntity product}) {
    return repository(product: product);
  }

  @override
  Future<Either<Exception, Unit>> clean() {
    return repository.clean();
  }
}
