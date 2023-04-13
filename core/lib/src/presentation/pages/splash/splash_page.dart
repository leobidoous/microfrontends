import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/legacy/global/controllers/global_auth_controller.dart';
import '../../../../core/legacy/routes/routes.dart';
import '../../../../core/legacy/widgets/logo_widget.dart';
import '../../../../core/utils/dependency_manager.dart';
import '../../../../core/utils/navigator_manager.dart';
import '../../../../features/app/presentation/controllers/app_controller.dart';
import '../../../../features/dashboard/presentation/dashboard_home_routes.dart';
import '../../controllers/splash_controller.dart';
import '../shared_routes.dart';
import '../warning_new_version/warning_new_version_page.dart';

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
    controller.onInit().then((value) {
      if (controller.hasError) {
        if (controller.needUpdate) {
          Nav.to.pushNamedAndRemoveUntil(
            SharedRoutes.warningNewVersion,
            ModalRoute.withName(SharedRoutes.warningNewVersion.completePath),
            arguments: WarningNewVersionPageArgs(
              forceUpdate: controller.forceUpdate,
              route: Routes.ONBOARDING,
            ),
          );
        } else {
          Nav.to.pushNamedAndRemoveUntil(
            Routes.ONBOARDING,
            ModalRoute.withName(Routes.ONBOARDING),
          );
        }
        return;
      }
      if (controller.needUpdate) {
        Nav.to.pushNamedAndRemoveUntil(
          SharedRoutes.warningNewVersion,
          ModalRoute.withName(SharedRoutes.warningNewVersion.completePath),
          arguments: WarningNewVersionPageArgs(
            forceUpdate: controller.forceUpdate,
            route: DashboardHomeRoutes.root.completePath,
          ),
        );
      } else {
        Nav.to.pushNamedAndRemoveUntil(
          DashboardHomeRoutes.root,
          ModalRoute.withName(DashboardHomeRoutes.root.completePath),
        );
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
