import 'package:core/core.dart';

import '../../data/datasources/register_datasource.dart';
import '../../infra/repositories/register_repository.dart';
import '../../infra/usecases/auth_usecase.dart';
import '../../infra/usecases/login_usecase.dart';
import '../../infra/usecases/register_usecase.dart';
import '../controllers/auth_controller.dart';
import '../controllers/login_controller.dart';
import '../controllers/register/register_address_controller.dart';
import '../controllers/register/register_controller.dart';
import '../pages/register/register_page.dart';
import 'login_module.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    /// Login
    ...LoginModule.exportedBinds,

    /// Register
    Bind.factory<RegisterDatasource>(
      (i) => RegisterDatasource(graphQlClient: i.get<GraphQlClientDriver>()),
    ),
    Bind.factory<RegisterRepository>(
      (i) => RegisterRepository(datasource: i.get<RegisterDatasource>()),
    ),
    Bind.factory<RegisterUsecase>(
      (i) => RegisterUsecase(repository: i.get<RegisterRepository>()),
    ),

    /// Controllers
    Bind.lazySingleton<RegisterController>(
      (i) => RegisterController(
        loginController: i.get<LoginController>(),
        registerUsecase: i.get<RegisterUsecase>(),
        authUsecase: DM.i.get<AuthUsecase>(),
        loginUsecase: DM.i.get<LoginUsecase>(),
        authController: DM.i.get<AuthController>(),
      ),
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
