import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';

abstract class IGetCartProductsUsecase {
  Future<Either<Exception, List<ProductEntity>>> call();
}
