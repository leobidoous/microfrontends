import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';


abstract class IGetPromotionsDatasource {
  Future<Either<Exception, List<ProductEntity>>> call();
}


