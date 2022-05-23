import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';

abstract class IGetCartProductsRepository {
  Future<Either<Exception, List<ProductEntity>>> call();
}
