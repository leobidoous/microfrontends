import 'package:core/core.dart';

import '../../domain/entities/stocks_entity.dart';
import '../../domain/usecases/stocks_usecase.dart';

class StocksDetailsStore extends NotifierStore<HttpDriverResponse, StocksEntity>
    with Disposable {
  final IStocksUsecase stocksDetailsUsecase;

  StocksDetailsStore({required this.stocksDetailsUsecase})
      : super(Object as StocksEntity);

  Future<void> getDetails({required String symbol}) async {
    setLoading(true);
    await stocksDetailsUsecase.getDetails(symbol: symbol).then((value) {
      value.fold(setError, update);
    }).whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    destroy();
  }
}
