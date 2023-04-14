import 'package:core/core.dart';

class AuthRoutes {
  static const BasePath root = BasePath('/auth/');
  static const BasePath login = BasePath('/login/', root);
  static const BasePath register = BasePath('/register/', root);
}
