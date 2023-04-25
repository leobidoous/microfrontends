import 'package:auth/auth.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../home/presentation/routes/dashboard_routes.dart';
import '../controllers/splash_controller.dart';
import '../shared_routes.dart';
import '../widgets/logo_widget.dart';
import 'warning_new_version_page.dart';

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
    controller.verifySession().then((value) async {
      if (controller.hasError) {
        await Future.delayed(const Duration(seconds: 1));
        if (controller.needUpdate) {
          Nav.to.navigate(
            SharedRoutes.warningNewVersion.relativePath,
            arguments: WarningNewVersionPageArgs(
              forceUpdate: controller.forceUpdate,
              onContinue: () {
                Nav.to.navigate(
                  AuthRoutes.root,
                  arguments: controller.appController.userPreferences,
                );
              },
            ),
          );
        } else {
          Nav.to.navigate(
            AuthRoutes.root,
            arguments: controller.appController.userPreferences,
          );
        }
        return;
      }
      if (controller.needUpdate) {
        Nav.to.navigate(
          SharedRoutes.warningNewVersion.relativePath,
          arguments: WarningNewVersionPageArgs(
            forceUpdate: controller.forceUpdate,
            onContinue: () => Nav.to.navigate(DashboardRoutes.root),
          ),
        );
      } else {
        Nav.to.navigate(DashboardRoutes.root);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox(
            width: context.mediaQuery.size.width,
            child: Image.asset(
              'assets/images/splash_background.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: context.mediaQuery.size.height * 0.52,
            child: SizedBox(
              width: context.mediaQuery.size.width,
              child: const Center(
                child: GenLogo(width: 224.0, height: 87.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
