import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/enums/settings_menu_enum.dart';

class SettingsMenuItem extends StatelessWidget {
  final SettingsMenuType menuItem;
  const SettingsMenuItem({
    Key? key,
    required this.menuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Modular.to.pushNamed(menuItem.route.completePath);
      },
      title: Text(
        menuItem.label,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      dense: true,
      visualDensity: VisualDensity.compact,
      contentPadding: EdgeInsets.zero,
      trailing: Icon(
        CoreIcons.chevronRight,
        color: Theme.of(context).textTheme.bodyText1?.color,
      ),
    );
  }
}
