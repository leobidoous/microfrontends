import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../auth.dart';
import '../../controllers/auth/auth_controller.dart';
import 'widgets/auth_logo.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final controller = DM.i.get<AuthController>();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/background_login_screen.png',
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(const Spacing(2).value),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const AuthLogo(),
                  Spacing.lg.vertical,
                  Text(
                    'Revolucione com a gente',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacing.lg.vertical,
                  CustomButton.text(
                    onPressed: () {
                      Nav.to.pushNamed(
                        AuthRoutes.login,
                        arguments: {
                          'redirectTo': controller.redirectTo,
                          'onLoginCallback': controller.onLoginCallback,
                        },
                      );
                    },
                    text: 'Login',
                  ),
                  Spacing.sm.vertical,
                  Theme(
                    data: context.theme.copyWith(
                      colorScheme: context.colorScheme.copyWith(
                        primary: context.colorScheme.background,
                      ),
                    ),
                    child: CustomButton.text(
                      type: ButtonType.background,
                      onPressed: () {
                        Nav.to.pushNamed(
                          AuthRoutes.register,
                          arguments: {
                            'redirectTo': controller.redirectTo,
                            'onLoginCallback': controller.onLoginCallback,
                          },
                        );
                      },
                      text: 'Cadastro',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
