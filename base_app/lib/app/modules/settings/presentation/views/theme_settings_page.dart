import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../shared/presentation/widgets/sub_page_app_bar.dart';
import '../../../../stores/app_theme_store.dart';

class ThemeSettingsPage extends StatefulWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  State<ThemeSettingsPage> createState() => _ThemeSettingsPageState();
}

class _ThemeSettingsPageState extends State<ThemeSettingsPage> {
  final store = Modular.get<AppThemeStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SubPageAppBar(title: 'Tema'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildRadioList),
        ],
      ),
    );
  }

  Widget get _buildRadioList {
    return ScopedBuilder(
      store: store,
      onState: (_, state) {
        return ListView.builder(
          itemCount: ThemeMode.values.length,
          itemBuilder: (_, index) {
            late final String title;
            switch (ThemeMode.values[index]) {
              case ThemeMode.system:
                title = 'Sistema';
                break;
              case ThemeMode.light:
                title = 'Claro';
                break;
              case ThemeMode.dark:
                title = 'Escuro';
                break;
            }
            return Theme(
              data: Theme.of(context).copyWith(
                radioTheme: Theme.of(context).radioTheme.copyWith(
                      fillColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
              ),
              child: RadioListTile<ThemeMode>(
                value: ThemeMode.values[index],
                controlAffinity: ListTileControlAffinity.trailing,
                title: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                activeColor: Theme.of(context).colorScheme.primary,
                selectedTileColor: Theme.of(context).colorScheme.onBackground,
                groupValue: store.state,
                onChanged: (mode) => store.changeThemeType(
                  mode ?? ThemeMode.system,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
