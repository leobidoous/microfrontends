import 'package:core/core.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/usecases/get_promotions_usecase.dart';

class HomePromotionsStore
    extends NotifierStore<Exception, List<ProductEntity>> {
  final IGetPromotionsUsecase usecase;
  HomePromotionsStore({required this.usecase}) : super([]);

  Future<void> getPromotions() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    usecase().then((value) => value.fold((l) => setError(l), (r) => update(r)));
    setLoading(false);
  }
}
