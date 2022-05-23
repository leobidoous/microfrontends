import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';

abstract class IAddProductToCartDatasource {
  Future<Either<Exception, Unit>> call({
    required ProductEntity product,
  });
}
