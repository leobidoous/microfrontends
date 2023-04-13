import 'package:core/core.dart';

import '../../app/presentation/app_routes.dart';

class HomeRoutes {
  static const BasePath root = BasePath('/', AppRoutes.home);
  static const BasePath wallet = BasePath('/wallet/', root);
}
