import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';

abstract class IRemoveProductFromCartDatasource {
  Future<Either<Exception, List<ProductEntity>>> call({
    required ProductEntity product,
  });
}
