import 'package:core/core.dart';

import '../../../home/domain/entities/product_entity.dart';

abstract class IGetCartProductsDatasource {
  Future<Either<Exception, List<ProductEntity>>> call();
}
