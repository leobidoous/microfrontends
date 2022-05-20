import 'package:dartz/dartz.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/get_promotions_repository.dart';
import '../datasources/get_promotions_datasource.dart';

class GetPromotionsRepository extends IGetPromotionsRepository {
  final IGetPromotionsDatasource datasource;

  GetPromotionsRepository({required this.datasource});

  @override
  Future<Either<Exception, List<ProductEntity>>> call() {
    return datasource();
  }
}
