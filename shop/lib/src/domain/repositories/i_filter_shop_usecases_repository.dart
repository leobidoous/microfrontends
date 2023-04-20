import '../entities/store_brand_entity.dart';
import '../entities/store_mall_entity.dart';

abstract class IFilterShopUsecasesRepository {
  Future<List<StoreBrandEntity>> fetchStoreBrands();
  Future<List<StoreMallEntity>> fetchStoreMalls();
}
