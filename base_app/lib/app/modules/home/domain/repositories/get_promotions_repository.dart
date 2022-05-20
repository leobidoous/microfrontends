import 'package:core/core.dart';

import '../entities/product_entity.dart';

abstract class IGetPromotionsRepository {
  Future<Either<Exception, List<ProductEntity>>> call();
}


