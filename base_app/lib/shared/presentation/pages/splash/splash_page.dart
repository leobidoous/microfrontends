import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../modules/app/presentation/app_routes.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = DM.i.get<SplashController>();

  @override
  void initState() {
    super.initState();
    controller.getLoggedlUser().then((value) {
      if (controller.state) {
        Nav.to.navigate(AppRoutes.home.completePath);
      } else {
        Nav.to.navigate(AppRoutes.auth.completePath);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DefaultImage(
          url: 'https://picsum.photos/id/58/500/1000',
          fit: BoxFit.fitHeight,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Center(
                child: DefaultCard(
                  padding: EdgeInsets.all(16),
                  child: Loading(
                    height: 40,
                    width: 40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
