import 'package:core/core.dart';

import '../../../domain/entities/store_brand_entity.dart';

abstract class IStoreBrandsDatasource {
  Future<Either<Exception, List<StoreBrandEntity>>> fetchStoreBrands({
    required Map<String, dynamic> params,
  });
}
