import 'package:core/core.dart';

import '../../app/modules/settings/presentation/settings_routes.dart';

enum SettingsMenuType {
  about,
  talkWithUs,
  themeSettings,
}

extension SettingsMenuTypeExt on SettingsMenuType {
  String get label {
    switch (this) {
      case SettingsMenuType.about:
        return 'Sobre o aplicativo';
      case SettingsMenuType.talkWithUs:
        return 'Fale conosco';
      case SettingsMenuType.themeSettings:
        return 'Tema';
    }
  }

  BasePath get route {
    switch (this) {
      case SettingsMenuType.about:
        return SettingsRoutes.about;
      case SettingsMenuType.talkWithUs:
        return SettingsRoutes.talkWithUs;
      case SettingsMenuType.themeSettings:
        return SettingsRoutes.themeSettings;
    }
  }
}
