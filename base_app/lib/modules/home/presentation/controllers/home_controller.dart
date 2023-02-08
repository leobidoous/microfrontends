import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import 'user_controller.dart';

class HomeController extends DefaultController<Exception, Unit> {
  final ILogoutUsecase logoutUsecase;
  final UserController userController;

  HomeController({
    required this.logoutUsecase,
    required this.userController,
  }) : super(unit);
}
