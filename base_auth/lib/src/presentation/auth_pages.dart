import 'package:get/get_navigation/get_navigation.dart';

import '../../../shared/infra/interfaces/module_middleware.dart';
import 'auth_routes.dart';
import 'bindings/auth/auth_bindings.dart';
import 'bindings/login/login_bindings.dart';
import 'pages/auth/auth_page.dart';
import 'pages/login/login_page.dart';

class AuthPages {
  static List<GetPage> pages = [
    GetPage(
      name: AuthRoutes.root.completePath,
      page: () => const AuthPage(),
      bindings: [AuthBindings(), LoginBindings()],
      transition: Transition.fadeIn,
      middlewares: [ModuleMiddleware<AuthPage>()],
    ),
    GetPage(
      name: AuthRoutes.login.completePath,
      page: () => const LoginPage(),
      transition: Transition.fadeIn,
    ),
  ];
}
