import 'package:base_style_sheet/base_style_sheet.dart' show DefaultLoading;
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../app_routes.dart';
import '../../../../modules/home/presentation/home_routes.dart';
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
        Modular.to.navigate(HomeRoutes.home.completePath);
        return;
      }
      Modular.to.navigate(AppRoutes.auth.completePath);
    });
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/space_background.png',
            package: 'core',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
        ),
        body: const Center(child: DefaultLoading()),
      ),
    );
  }
}
