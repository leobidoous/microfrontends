import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../app/presentation/app_routes.dart';
import 'controllers/home_controller.dart';
import 'controllers/user_controller.dart';
import 'home_routes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = DM.i.get<HomeController>();
  final userController = DM.i.get<UserController>();
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // controller.userController.getUser();
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DefaultAppBar(
        title: Text(
          'Início',
          style: context.textTheme.titleSmall?.copyWith(
            color: context.colorScheme.background,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              controller.logoutUsecase().then((value) {
                value.fold(
                  (l) => null,
                  (r) => Nav.to.navigate(AppRoutes.auth.completePath),
                );
              });
            },
            child: Icon(
              Icons.exit_to_app_rounded,
              color: context.colorScheme.background,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacing.sm.vertical,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Olá, ${controller.userController.state.name}',
                style: context.textTheme.titleMedium,
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Button(
                child: Text(
                  'Transações',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  Nav.to.pushNamed(HomeRoutes.wallet.completePath);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
