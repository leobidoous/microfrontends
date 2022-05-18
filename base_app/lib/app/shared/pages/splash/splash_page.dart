import 'package:base_style_sheet/base_style_sheet.dart'
    show DefaultLoadingWidget;
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../../core/app_routes.dart';
import 'splash_store.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final SplashStore store = Modular.get<SplashStore>();

  @override
  void initState() {
    super.initState();
    store.getLoggedlUser().then((value) {
      if (store.state) {
        Modular.to.navigate('${AppRoutes.home}/');
        return;
      }
      Modular.to.navigate(
        '${AppRoutes.auth}/',
        arguments: '${AppRoutes.home}/',
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: const Center(child: DefaultLoadingWidget()),
    );
  }
}
