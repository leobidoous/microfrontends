import 'package:core/core.dart';


class AppRoutes {
  static const BasePath root = BasePath('/');
  static const BasePath home = BasePath('/home/', root);
  static const BasePath auth = BasePath('/auth/login/', root);
}
