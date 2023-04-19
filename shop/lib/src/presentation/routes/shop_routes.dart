import 'package:core/core.dart';

class ShopRoutes {
  ShopRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/shop/', _parent);
  static BasePath filterShop = BasePath('/filter_shop/', root);
}
