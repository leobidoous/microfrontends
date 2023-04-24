import 'package:core/core.dart';

class AuthRoutes {
  AuthRoutes({required BasePath parent}) {
    _parent = parent;
  }

  BasePath get initial => root;
  static late final BasePath _parent;

  static BasePath root = BasePath('/auth/', _parent);
  static BasePath login = BasePath('/login/', root);
}
