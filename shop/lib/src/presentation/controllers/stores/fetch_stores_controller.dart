import 'package:core/core.dart' hide DateFormat;
import 'package:intl/intl.dart';

import '../../../domain/entities/store_entity.dart';
import '../../../domain/usecases/dashboard_shop/i_store_usecase.dart';

class FetchStoresController
    extends GenController<Exception, List<StoreEntity>> {
  FetchStoresController({required this.usecase}) : super([]);

  final IStoreUsecase usecase;
  String day = '';

  Future<void> fetchStores({required Map<String, dynamic> params}) async {
    execute(() => usecase.fetchStores(params: params));
  }

  void setCurrentDay() {
    day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
  }
}
