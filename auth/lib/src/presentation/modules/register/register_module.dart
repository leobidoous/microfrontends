import 'package:auth/src/presentation/controllers/login/login_controller.dart';
import 'package:auth/src/presentation/controllers/register/register_address_controller.dart';
import 'package:auth/src/presentation/controllers/register/register_controller.dart';
import 'package:auth/src/presentation/modules/login/login_module.dart';
import 'package:core/core.dart';

import '../../pages/register/register_page.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    /// Login
    ...LoginModule.exportedBinds,

    /// Controllers
    Bind.factory<RegisterController>(
      (i) => RegisterController(loginController: i.get<LoginController>()),
    ),
    Bind.factory<RegisterAddressController>(
      (i) => RegisterAddressController(
        usecase: i.get<SearchPostalCodeUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => RegisterPage(
        onLoginCallback: args.data['onLoginCallback'],
        redirectTo: args.data['redirectTo'],
      ),
    ),
  ];
}
