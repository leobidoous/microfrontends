import 'package:core/core.dart';

import '../../../stores/app_store.dart';
import 'settings_routes.dart';
import 'stores/about_app_store.dart';
import 'stores/settings_store.dart';
import 'views/about_app_page.dart';
import 'views/settings_page.dart';
import 'views/talk_with_us_page.dart';
import 'views/theme_settings_page.dart';

class SettingsModule extends Module {
  @override
  final List<Bind> binds = [
    /// Store dependencies
    Bind.lazySingleton((i) => SettingsStore(appStore: i.get<AppStore>())),
    Bind.lazySingleton((i) => AboutAppStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      SettingsRoutes.root.path,
      child: (_, args) => const SettingsPage(),
    ),
    ChildRoute(
      SettingsRoutes.about.path,
      transition: TransitionType.defaultTransition,
      child: (_, args) => const AboutAppPage(),
    ),
    ChildRoute(
      SettingsRoutes.themeSettings.path,
      transition: TransitionType.defaultTransition,
      child: (_, args) => const ThemeSettingsPage(),
    ),
    ChildRoute(
      SettingsRoutes.talkWithUs.path,
      transition: TransitionType.defaultTransition,
      child: (_, args) => const TalkWithUsPage(),
    ),
  ];
}
