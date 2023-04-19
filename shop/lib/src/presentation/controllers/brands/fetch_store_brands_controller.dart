import 'package:core/core.dart';

import '../../../domain/entities/store_brand_entity.dart';
import '../../../domain/usecases/brands/i_store_brands_usecase.dart';

class FetchStoreBrandsController
    extends GenController<Exception, List<StoreBrandEntity>> {
  final IStoreBrandsUsecase usecase;

  FetchStoreBrandsController({
    required this.usecase,
  }) : super([]);

  Future<void> fetchStoreBrands({
    Map<String, dynamic> params = const {},
  }) async {
    execute(() => usecase.fetchStoreBrands(params: params));
  }
}
