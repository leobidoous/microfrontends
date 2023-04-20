import '../entities/store_entity.dart';

abstract class IDashboardShopUsecasesRepository {
  Future<List<StoreEntity>> fetchStores({
    required Map<String, dynamic> params,
  });
}
