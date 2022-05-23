import 'package:core/core.dart';

import '../entities/product_entity.dart';

abstract class IAddProductToCartRepository {
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  });
}
