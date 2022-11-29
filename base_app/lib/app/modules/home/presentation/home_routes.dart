import 'package:core/core.dart';

import '../../../app_routes.dart';

class HomeRoutes {
  /// module
  static const BasePath root = BasePath('/', AppRoutes.main);

  /// home
  static const BasePath home = BasePath('/home/', root);

  /// settings
  static const BasePath settings = BasePath('/settings/', root);

  /// search
  static const BasePath search = BasePath('/search/', root);

  /// chat
  static const BasePath chat = BasePath('/chat/', root);

  /// notifications
  static const BasePath notifications = BasePath('/notifications/', root);
}
