import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import 'app_theme_store.dart';

class AppStore extends NotifierStore<Exception, Unit> {
  final AppThemeStore themeStore;
  final LoggedUserStore userStore;

  AppStore({
    required this.themeStore,
    required this.userStore,
  }) : super(unit);
}
