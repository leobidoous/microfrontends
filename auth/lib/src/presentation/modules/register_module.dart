import 'package:core/core.dart';

import '../../../auth.dart';
import '../../data/datasources/register_datasource.dart';
import '../../infra/repositories/register_repository.dart';
import '../../infra/usecases/register_usecase.dart';
import '../controllers/login_controller.dart';
import '../controllers/register/register_address_controller.dart';
import '../controllers/register/register_controller.dart';
import '../controllers/timer_controller.dart';
import '../controllers/validate_email_controller.dart';
import '../pages/register/register/register_page.dart';
import '../pages/register/validate_email/validate_email_page.dart';
import 'login_module.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
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
    Bind.factory<TimerController>((i) => TimerController()),
    Bind.lazySingleton<RegisterController>(
      (i) => RegisterController(
        loginController: DM.i.get<LoginController>(),
        registerUsecase: i.get<RegisterUsecase>(),
      ),
    ),
    Bind.factory<RegisterAddressController>(
      (i) => RegisterAddressController(
        usecase: i.get<SearchPostalCodeUsecase>(),
      ),
    ),
    Bind.factory<ValidateEmailController>(
      (i) => ValidateEmailController(
        registerUsecase: i.get<RegisterUsecase>(),
        userUsecase: i.get<UserUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      transition: TransitionType.defaultTransition,
      child: (_, args) => RegisterPage(redirectTo: args.data['redirectTo']),
    ),
    ChildRoute(
      RegisterRoutes.validateEmail.path,
      transition: TransitionType.defaultTransition,
      child: (_, args) => ValidateEmailPage(
        onValidateCallback: args.data['onValidateCallback'],
        redirectTo: args.data['redirectTo'],
      ),
    ),
  ];
}
