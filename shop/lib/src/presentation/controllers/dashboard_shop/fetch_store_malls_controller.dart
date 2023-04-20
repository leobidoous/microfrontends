import 'package:core/core.dart';

import '../../../domain/entities/store_mall_entity.dart';
import '../../../domain/usecases/dashboard_shop/i_store_usecase.dart';

class FetchStoreMallsController
    extends GenController<Exception, List<StoreMallEntity>> {
  final IStoreUsecase usecase;

  FetchStoreMallsController({required this.usecase}) : super([]);

  Future<void> fetchStoreMalls() async {
    execute(() => usecase.fetchStoreMalls());
  }
}
