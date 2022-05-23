import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';
import '../repositories/get_cart_products_repository.dart';

abstract class IGetCartProductsUsecase {
  Future<Either<Exception, List<ProductEntity>>> call();
}

class GetCartProductsUsecase extends IGetCartProductsUsecase {
  final IGetCartProductsRepository repository;

  GetCartProductsUsecase({required this.repository});

  @override
  Future<Either<Exception, List<ProductEntity>>> call() {
    return repository();
  }
}
