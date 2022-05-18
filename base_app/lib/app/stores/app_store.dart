import 'package:core/core.dart';

import 'app_theme_store.dart';

class AppStore extends NotifierStore<Exception, Unit> {
  final AppThemeStore themeStore;
  
  AppStore({required this.themeStore}) : super(unit);
}
