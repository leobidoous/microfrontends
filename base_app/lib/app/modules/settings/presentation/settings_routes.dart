import 'package:core/core.dart';

import '../../home/presentation/home_routes.dart';

class SettingsRoutes {
  /// [root] path
  static const BasePath root = BasePath('/', HomeRoutes.settings);

  /// [about] path
  static const BasePath about = BasePath('/about/', root);

  /// [about] path
  static const BasePath themeSettings = BasePath('/themeSettings/', root);

  /// [about] path
  static const BasePath talkWithUs = BasePath('/talkWithUs/', root);
}
