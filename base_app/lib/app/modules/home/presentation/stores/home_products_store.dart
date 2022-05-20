import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/entities/search_products_filters_entity.dart';
import '../../domain/usecases/get_products_usecase.dart';

class HomeProductsStore extends NotifierStore<Exception, List<ProductEntity>> {
  final IGetProductsUsecase usecase;
  final SearchProductsFiltersEntity params = SearchProductsFiltersEntity();
  HomeProductsStore({required this.usecase}) : super([]) {
    params.q = ' ';
  }

  Future<void> getProducts() async {
    setLoading(true);
    usecase(params: params).then(
      (value) => value.fold((l) => setError(l), (r) => update(r)),
    );
    setLoading(false);
  }
}
