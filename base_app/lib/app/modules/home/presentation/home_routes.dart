import 'package:core/core.dart';

import '../../../app_routes.dart';

class HomeRoutes {
  /// module
  static const BasePath root = BasePath('/', AppRoutes.main);

  /// home
  static const BasePath home = BasePath('/home/', root);

  /// settings
  static const BasePath settings = BasePath('/settings/', root);

  /// stocks 
  static const BasePath stocks = BasePath('/stocks/', root);

}
