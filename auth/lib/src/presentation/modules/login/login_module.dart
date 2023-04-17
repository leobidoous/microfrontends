import 'package:core/core.dart';

import '../../../data/datasources/login_datasource.dart';
import '../../../infra/repositories/login_repository.dart';
import '../../../infra/usecases/auth_usecase.dart';
import '../../../infra/usecases/login_usecase.dart';
import '../../../infra/usecases/user_usecase.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../controllers/login/login_controller.dart';
import '../../controllers/timer_controller.dart';
import '../../pages/login/login_page.dart';

class LoginModule extends Module {
  static List<Bind> get exportedBinds => [
        Bind.lazySingleton(
          (i) =>
              LoginDatasource(graphQlClient: DM.i.get<GraphQlClientDriver>()),
        ),
        Bind.lazySingleton(
          (i) => LoginRepository(datasource: DM.i.get<LoginDatasource>()),
        ),
        Bind.lazySingleton(
          (i) => LoginUsecase(repository: DM.i.get<LoginRepository>()),
        ),

        /// Controllers
        Bind.lazySingleton<LoginController>(
          (i) => LoginController(
            userUsecase: DM.i.get<UserUsecase>(),
            authUsecase: DM.i.get<AuthUsecase>(),
            loginUsecase: DM.i.get<LoginUsecase>(),
            authController: DM.i.get<AuthController>(),
            timerController: DM.i.get<TimerController>(),
          ),
        ),
        Bind.factory<TimerController>((i) => TimerController()),
      ];

  @override
  final List<Bind> binds = [
    ...exportedBinds,
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => LoginPage(
        onLoginCallback: args.data['onLoginCallback'],
        redirectTo: args.data['redirectTo'],
      ),
    ),
  ];
}
