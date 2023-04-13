import 'package:get/get.dart';

import '../../../data/datasources/login_datasource.dart';
import '../../../infra/repositories/login_repository.dart';
import '../../../infra/usecases/auth_usecase.dart';
import '../../../infra/usecases/login_usecase.dart';
import '../../controllers/login/login_controller.dart';
import '../../controllers/login/login_timer_controller.dart';

class LoginBindings extends Bindings {
  @override
  void dependencies() {
    Factory<LoginDatasource>(
      () => LoginDatasource(graphQlClient: DM.i.get<GraphQlClientDriver>()),
    );
    Factory<LoginRepository>(
      () => LoginRepository(datasource: DM.i.get<LoginDatasource>()),
    );
    Factory<LoginUsecase>(
      () => LoginUsecase(repository: DM.i.get<LoginRepository>()),
    );

    /// Controllers
    LazySingleton<LoginController>(
      () => LoginController(
        userUsecase: DM.i.get<UserUsecase>(),
        authUsecase: DM.i.get<AuthUsecase>(),
        loginUsecase: DM.i.get<LoginUsecase>(),
        mixpanel: DM.i.get<MixPanelController>(),
        appController: DM.i.get<AppController>(),
        globalController: DM.i.get<GlobalController>(),
        timerController: DM.i.get<LoginTimerController>(),
        globalAuthController: DM.i.get<GlobalAuthController>(),
      ),
    );
    Factory<LoginTimerController>(() => LoginTimerController());
  }
}
