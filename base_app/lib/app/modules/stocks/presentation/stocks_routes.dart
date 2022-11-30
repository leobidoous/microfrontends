import 'package:core/core.dart';

import '../../home/presentation/home_routes.dart';

class StocksRoutes {
  /// module
  static const BasePath root = BasePath('/', HomeRoutes.stocks);

  /// stocks list
  static const BasePath stocksList = BasePath('/stocks_list/', root);

  /// stocks details
  static const BasePath stocksDetails = BasePath('/stocks_details/', root);
}
