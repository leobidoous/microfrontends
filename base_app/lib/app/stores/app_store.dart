import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import 'app_theme_store.dart';

class AppStore extends NotifierStore<Exception, Unit> {
  final AppThemeStore themeStore;
  final ILogoutUsecase logoutUsecase;

  AppStore({
    required this.themeStore,
    required this.logoutUsecase,
  }) : super(unit);

  Future<Either<Exception, Unit>> logout() async {
    return logoutUsecase();
  }
}
