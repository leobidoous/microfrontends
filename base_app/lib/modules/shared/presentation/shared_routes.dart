import 'package:core/core.dart';

import '../../app/presentation/app_routes.dart';

class SharedRoutes {
  static const BasePath root = BasePath('/shared/', AppRoutes.root);
  static const BasePath splash = BasePath('/splash/', root);
  static const BasePath comming = BasePath('/comming_soon/', root);
  static const BasePath warningNewVersion = BasePath(
    '/warning_new_version/',
    root,
  );
  static const BasePath fallback = BasePath('/fallback/', root);
}
