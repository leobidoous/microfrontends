import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/legacy/widgets/logo_widget.dart';
import '../../../../../core/themes/app_theme_factory.dart';
import '../../../../../core/themes/spacing/spacing.dart';
import '../../../../../core/utils/dependency_manager.dart';
import '../../../../../shared/presentation/widgets/buttons/gen_button.dart';
import '../../controllers/auth/auth_controller.dart';

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
                  const GenLogo(),
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
                  GenButton.text(
                    onPressed: controller.onSignInButtonClick,
                    text: 'Login',
                  ),
                  Spacing.sm.vertical,
                  Theme(
                    data: context.theme.copyWith(
                      colorScheme: context.colorScheme.copyWith(
                        primary: context.colorScheme.background,
                      ),
                    ),
                    child: GenButton.text(
                      type: ButtonType.background,
                      onPressed: controller.onStartButtonClick,
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
