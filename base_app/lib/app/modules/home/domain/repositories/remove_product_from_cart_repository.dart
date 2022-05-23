import 'package:core/core.dart';

import '../entities/product_entity.dart';

abstract class IRemoveProductFromCartRepository {
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  });
}
