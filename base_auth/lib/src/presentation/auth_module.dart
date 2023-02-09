import 'package:core/core.dart';

import '../data/datasources/login/login_with_email_datasource.dart';
import '../domain/usecases/login/login_with_email_usecase.dart';
import '../infra/repositories/login/login_with_email_repository.dart';
import 'controllers/login_controller.dart';
import 'pages/login_page.dart';

class AuthModule extends Module {
  static late final BasePath _redirectTo;
  static late final Future Function(UserEntity) _onLoginCallback;

  AuthModule({
    required BasePath redirectTo,
    required Future Function(UserEntity) onLoginCallback,
  }) {
    _redirectTo = redirectTo;
    _onLoginCallback = onLoginCallback;
  }

  @override
  final List<Bind> binds = [
    /// Global
    Bind.singleton(
      (i) => DioClientDriver(
        client: Dio(DM.i.get<BaseOptions>())
          ..interceptors.add(
            LogInterceptor(
              requestBody: true,
              responseHeader: false,
            ),
          ),
      ),
    ),

    /// Login with email
    Bind.lazySingleton(
      (i) => LoginWithEmailDatasource(
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
        client: DM.i.get<DioClientDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => LoginWithEmailRepository(
        datasource: DM.i.get<LoginWithEmailDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => LoginWithEmailUsecase(
        repository: DM.i.get<LoginWithEmailRepository>(),
      ),
    ),

    /// Stores
    Bind.lazySingleton(
      (i) => LoginController(
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
        loginUsecase: DM.i.get<LoginWithEmailUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => LoginPage(
        onLoginCallback: _onLoginCallback,
        redirectTo: _redirectTo,
      ),
    ),
  ];
}
