import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enums/settings_menu_enum.dart';
import '../../../../app_routes.dart';
import '../../../../shared/presentation/widgets/logout_confirmation.dart';
import '../stores/settings_store.dart';
import '../widgets/settings_menu_item.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final store = Modular.get<SettingsStore>();

  Future<void> logout() async {
    await DefaultDialog()
        .show(context, const LogoutConfirmation())
        .then((value) {
      if (value != true) return value;
      return store.appStore.logout().then((value) {
        return value.fold(
          (l) => DefaultDialog().error(context, message: l.toString()),
          (r) => Modular.to.navigate(AppRoutes.auth.completePath),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildSettingsList),
          Padding(
            padding: const EdgeInsets.all(16),
            child: _buildExitButton,
          ),
        ],
      ),
    );
  }

  Widget get _buildSettingsList {
    return ListView.separated(
      itemCount: [
        SettingsMenuType.about,
        // SettingsMenuType.talkWithUs,
        // SettingsMenuType.themeSettings,
      ].length,
      padding: const EdgeInsets.all(16),
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (_, index) {
        return SettingsMenuItem(
          menuItem: SettingsMenuType.values[index],
        );
      },
    );
  }

  Widget get _buildExitButton {
    return DefaultButton(
      onPressed: logout,
      type: ButtonType.background,
      text: Text(
        'Sair',
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
