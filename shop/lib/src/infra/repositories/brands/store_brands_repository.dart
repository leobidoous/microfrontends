import 'package:core/core.dart';

import '../../../domain/entities/store_brand_entity.dart';
import '../../../domain/repositories/brands/i_store_brands_repository.dart';
import '../../datasources/brands/i_store_brands_datasource.dart';

class StoreBrandsRepository implements IStoreBrandsRepository {
  const StoreBrandsRepository({
    required this.dataSource,
  });

  final IStoreBrandsDatasource dataSource;

  @override
  Future<Either<Exception, List<StoreBrandEntity>>> fetchStoreBrands({
    required Map<String, dynamic> params,
  }) async {
    return dataSource.fetchStoreBrands(params: params);
  }
}
