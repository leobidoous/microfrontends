import 'package:core/core.dart';

class AppRoutes {
  /// module
  static const BasePath root = BasePath('/');

  /// main
  static const BasePath main = BasePath('/main/', root);

  /// auth
  static const BasePath auth = BasePath('/auth/', root);
}
