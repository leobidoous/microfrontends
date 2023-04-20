import '../entities/store_brand_entity.dart';
import '../repositories/i_filter_shop_usecases_repository.dart';

class FetchStoreBrands {
  FetchStoreBrands(this.repository);
  final IFilterShopUsecasesRepository repository;

  Future<List<StoreBrandEntity>> call() async {
    final result = repository.fetchStoreBrands();

    return result;
  }
}
