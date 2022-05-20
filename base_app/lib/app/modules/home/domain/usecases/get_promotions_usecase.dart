import 'package:core/core.dart';

import '../entities/product_entity.dart';
import '../repositories/get_promotions_repository.dart';

abstract class IGetPromotionsUsecase {
  Future<Either<Exception, List<ProductEntity>>> call();
}

class GetPromotionsUsecase extends IGetPromotionsUsecase {
  final IGetPromotionsRepository repository;

  GetPromotionsUsecase({required this.repository});

  @override
  Future<Either<Exception, List<ProductEntity>>> call() {
    return repository();
  }
}
