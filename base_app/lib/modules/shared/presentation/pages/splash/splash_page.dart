import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../widgets/logo_widget.dart';
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
    controller.onInit().then((value) {
      if (controller.hasError) {
        if (controller.needUpdate) {
          Nav.to.pushNamedAndRemoveUntil(
            SharedRoutes.warningNewVersion,
            ModalRoute.withName(SharedRoutes.warningNewVersion.completePath),
            
          );
        } else {
          Nav.to.pushNamedAndRemoveUntil(
            'Routes.ONBOARDING',
            ModalRoute.withName(''),
          );
        }
        return;
      }
      if (controller.needUpdate) {
        Nav.to.pushNamedAndRemoveUntil(
          SharedRoutes.warningNewVersion,
          ModalRoute.withName(SharedRoutes.warningNewVersion.completePath),
        );
      } else {
        Nav.to.pushNamedAndRemoveUntil(
          'DashboardHomeRoutes.root',
          ModalRoute.withName(''),
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
