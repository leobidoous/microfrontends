import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' show Modular;
import 'package:flutter/material.dart';

import '../../../../core/app_routes.dart';
import '../../../../core/enums/app_theme_type.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeStore store = Modular.get<HomeStore>();

  void logout() {
    store.logout().then((value) {
      value.fold(
        (l) => DefaultDialog().show(
            context,
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(l.toString()),
            ),
            showClose: true),
        (r) => Modular.to.navigate(
          '${AppRoutes.auth}/',
          arguments: '${AppRoutes.home}/',
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 8),
            child: InkWell(
              onTap: () {
                switch (store.appStore.themeStore.state) {
                  case AppThemeType.dark:
                    store.appStore.themeStore
                        .changeThemeType(AppThemeType.light);
                    break;
                  case AppThemeType.light:
                    store.appStore.themeStore
                        .changeThemeType(AppThemeType.dark);
                    break;
                }
              },
              child: const Icon(Icons.change_circle_rounded),
            ),
          ),
        ],
      ),
      body: const Center(child: Text('Authenticated')),
      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        child: const Icon(Icons.exit_to_app_rounded),
      ),
    );
  }
}
