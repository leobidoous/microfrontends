import 'package:core/core.dart';

import '../../../domain/entities/store_brand_entity.dart';
import '../../../domain/repositories/brands/i_store_brands_repository.dart';
import '../../../domain/usecases/brands/i_store_brands_usecase.dart';

class FetchStoreBrandsUsecase implements IStoreBrandsUsecase {
  FetchStoreBrandsUsecase({
    required this.repository,
  });

  final IStoreBrandsRepository repository;

  @override
  Future<Either<Exception, List<StoreBrandEntity>>> fetchStoreBrands({
    required Map<String, dynamic> params,
  }) {
    final result = repository.fetchStoreBrands(params: params);
    return result;
  }
}
