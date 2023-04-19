import '../entities/store_entity.dart';
import '../repositories/i_dashboard_shop_usecases_repository.dart';

class FetchStores {
  FetchStores(this.repository);
  final IDashboardShopUsecasesRepository repository;

  Future<List<StoreEntity>> call({
    required Map<String, dynamic> params,
  }) async {
    final result = repository.fetchStores(params: params);

    return result;
  }
}
