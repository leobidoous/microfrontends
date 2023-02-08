import 'package:core/core.dart';

import '../../app/presentation/app_routes.dart';

class HomeRoutes {
  static const BasePath root = BasePath('/', AppRoutes.home);
  static const BasePath productsList = BasePath('/products_list/', root);
  static const BasePath productDetails = BasePath('/product_details/', root);
}
