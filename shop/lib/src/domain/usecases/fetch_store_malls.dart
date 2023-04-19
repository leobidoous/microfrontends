import '../entities/store_mall_entity.dart';
import '../repositories/i_filter_shop_usecases_repository.dart';

class FetchStoreMalls {
  FetchStoreMalls(this.repository);
  final IFilterShopUsecasesRepository repository;

  Future<List<StoreMallEntity>> call() async {
    final result = repository.fetchStoreMalls();

    return result;
  }
}
