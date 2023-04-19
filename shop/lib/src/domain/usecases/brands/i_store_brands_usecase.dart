import 'package:core/core.dart';

import '../../entities/store_brand_entity.dart';

abstract class IStoreBrandsUsecase {
  Future<Either<Exception, List<StoreBrandEntity>>> fetchStoreBrands({
    required Map<String, dynamic> params,
  });
}
