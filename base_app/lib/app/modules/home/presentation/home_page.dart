import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart' show Modular;
import 'package:flutter/material.dart';

import '../../../../core/app_routes.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, this.title = 'Home'}) : super(key: key);

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
      ),
      body: const Center(child: Text('Authenticated')),
      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        child: const Icon(Icons.exit_to_app_rounded),
      ),
    );
  }
}
