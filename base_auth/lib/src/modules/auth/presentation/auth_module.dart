import 'package:core/core.dart'
    show
        BaseOptions,
        BasePath,
        Bind,
        ChildRoute,
        DefaultInterceptor,
        Dio,
        DioClientDriver,
        LocalStorageDriver,
        ModularRoute,
        Module,
        NotFoundPage,
        WildcardRoute;

import '../../../core/auth_routes.dart';
import '../../login/presentation/stores/fake_login_store.dart';
import '../../login/presentation/stores/microsoft_login_store.dart';
import '../../login/presentation/views/login_page.dart';
import '../data/datasources/logged_user_datasource.dart';
import '../data/datasources/microsoft_sso_datasource.dart';
import '../domain/usecases/logged_user_usecase.dart';
import '../domain/usecases/microsoft_sso_usecase.dart';
import '../infra/repositories/logged_user_repository.dart';
import '../infra/repositories/microsoft_sso_repository.dart';

class AuthModule extends Module {
  static late final BasePath nextPage;

  void setNextPage({required BasePath path}) => nextPage = path;

  @override
  final List<Bind> binds = [
    /// Http dependencies
    Bind.lazySingleton(
      (i) => DioClientDriver(
        client: Dio(
          BaseOptions(
            connectTimeout: 20000,
            receiveTimeout: 20000,
            sendTimeout: 20000,
          ),
        )..interceptors.addAll([DefaultInterceptor()]),
      ),
    ),

    /// Logged user dependencies
    Bind.lazySingleton(
      (i) => LoggedUserDatasource(storageDriver: i.get<LocalStorageDriver>()),
    ),
    Bind.lazySingleton(
      (i) => LoggedUserRepository(datasource: i.get<LoggedUserDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => LoggedUserUsecase(repository: i.get<LoggedUserRepository>()),
    ),

    /// Microsoft SSO dependencies
    Bind.lazySingleton(
      (i) => MicrosoftSSODatasource(
        client: i.get<DioClientDriver>(),
        loggedUserUsecase: i.get<LoggedUserUsecase>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => MicrosoftSSORepository(
        datasource: i.get<MicrosoftSSODatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => MicrosoftSSOUsecase(repository: i.get<MicrosoftSSORepository>()),
    ),

    /// Local storage dependencies
    Bind.lazySingleton((i) => LocalStorageDriver()),

    ///  stores dependencies
    Bind.lazySingleton(
      (i) => MicrosoftLoginStore(ssoUsecase: i.get<MicrosoftSSOUsecase>()),
    ),
    Bind.lazySingleton(
      (i) => FakeLoginStore(loggedUserUsecase: i.get<LoggedUserUsecase>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      AuthRoutes.root.path,
      child: (_, args) => LoginPage(loginFoward: nextPage),
    ),
    WildcardRoute(child: (_, args) => const NotFoundPage()),
  ];
}
