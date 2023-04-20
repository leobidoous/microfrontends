import 'package:core/core.dart';

class BrandsRoutes {
  BrandsRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/brands/', _parent);
}
