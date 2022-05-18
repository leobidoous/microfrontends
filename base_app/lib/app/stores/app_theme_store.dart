import 'package:core/core.dart';

import '../../core/enums/app_theme_type.dart';

class AppThemeStore extends NotifierStore<Exception, AppThemeType> {
  AppThemeStore() : super(AppThemeType.light);

  void changeThemeType(AppThemeType type) => update(type);
}
