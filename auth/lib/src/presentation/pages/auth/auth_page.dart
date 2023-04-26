import 'package:base_style_sheet/base_style_sheet.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

import '../../../../auth.dart';
import '../../controllers/auth_controller.dart';
import '../../routes/login_routes.dart';
import 'widgets/auth_logo.dart';
import 'widgets/onboarding_view.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final controller = DM.i.get<AuthController>();
  final pageController = PageController(initialPage: 1);

  @override
  void initState() {
    controller.getUserPreferences().then(
          (value) => value.fold((l) => null, (r) {
            if (r.showOnboarding ?? false) {
              pageController.jumpToPage(0);
            }
          }),
        );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        OnboardingView(
          onClose: () {
            controller.setUserPreferences(
              UserPreferencesEntity(id: '', showOnboarding: false),
            );
            pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 250),
              curve: Curves.decelerate,
            );
          },
        ),
        Scaffold(
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
                  padding: EdgeInsets.all(const Spacing(3).value),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const AuthLogo(),
                      Spacing.lg.vertical,
                      Text(
                        'Revolucione com a gente',
                        textAlign: TextAlign.center,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontSize: 18.responsiveHeight,
                          fontWeight: context.textTheme.fontWeightBold,
                        ),
                      ),
                      Spacing.lg.vertical,
                      CustomButton.text(
                        onPressed: () {
                          Nav.to.pushNamed(
                            LoginRoutes.root,
                            arguments: {'redirectTo': controller.redirectTo},
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
                              RegisterRoutes.root,
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
        ),
      ],
    );
  }
}
