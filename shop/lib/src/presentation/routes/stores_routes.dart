import 'package:core/core.dart';

class StoresRoutes {
  StoresRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/stores/', _parent);
  static BasePath detailsStore = BasePath('/details_store/', root);
}
