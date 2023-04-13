import 'package:core/core.dart';

import '../../auth_routes.dart';

class AuthController extends GenController<Exception, Unit> {
  AuthController({
    required this.redirectTo,
    required this.onLoginCallback,
  }) : super(unit);

  final BasePath redirectTo;
  final Future Function() onLoginCallback;

  void onStartButtonClick() async {
    Nav.to.pushNamed(AuthRoutes.login);
  }

  void onSignInButtonClick() async {
    Nav.to.pushNamed(AuthRoutes.login);
  }
}
