import 'package:core/core.dart';

import '../../domain/entities/stocks_entity.dart';
import '../../domain/usecases/stocks_usecase.dart';

class StocksListStore
    extends NotifierStore<HttpDriverResponse, List<StocksEntity>>
    with Disposable {
  final IStocksUsecase stocksDetailsUsecase;

  StocksListStore({required this.stocksDetailsUsecase}) : super([]);

  Future<void> list({required String term}) async {
    setLoading(true);
    await stocksDetailsUsecase.list(term: term).then((value) {
      value.fold(setError, update);
    }).whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    destroy();
  }
}
