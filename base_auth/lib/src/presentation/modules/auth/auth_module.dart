import 'package:core/core.dart';

import '../../../data/datasources/auth_datasource.dart';
import '../../../data/datasources/user_datasource.dart';
import '../../../infra/repositories/auth_repository.dart';
import '../../../infra/repositories/user_repository.dart';
import '../../../infra/usecases/auth_usecase.dart';
import '../../../infra/usecases/user_usecase.dart';
import '../../auth_routes.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../pages/auth/auth_page.dart';
import '../login/login_module.dart';

class AuthModule extends Module {
  static late final BasePath _redirectTo;
  static late final Future Function() _onLoginCallback;

  AuthModule({
    required BasePath redirectTo,
    required Future Function() onLoginCallback,
  }) {
    _redirectTo = redirectTo;
    _onLoginCallback = onLoginCallback;
  }

  static List<Bind> get exportedBinds => [
        /// Auth
        Bind.lazySingleton<AuthDatasource>(
          (i) => AuthDatasource(
            client: DioClientDriver(
              client: Dio()
                ..options.baseUrl = i.get<EnvironmentEntity>().baseUrlParking
                ..interceptors.addAll([LogInterceptor(requestBody: true)]),
            ),
            graphQlClient: GraphQlClientDriver(
              baseUrl: i.get<EnvironmentEntity>().endpointGraphql,
              localUserUsecase: i.get<LocalUserUsecase>(),
              client: GraphQLClient(
                link: Link.from([]),
                cache: GraphQLCache(store: HiveStore()),
              ),
            ),
            firebaseAuthDriver: i.get<FirebaseAuthDriver>(),
            localUserUsecase: i.get<LocalUserUsecase>(),
          ),
        ),
        Bind.lazySingleton<AuthRepository>(
          (i) => AuthRepository(datasource: i.get<AuthDatasource>()),
        ),
        Bind.lazySingleton<AuthUsecase>(
          (i) => AuthUsecase(repository: i.get<AuthRepository>()),
        ),

        /// Remote user
        Bind.factory<UserDatasource>(
          (i) => UserDatasource(
            graphQlClient: i.get<GraphQlClientDriver>(),
            firebaseAuthDriver: i.get<FirebaseAuthDriver>(),
          ),
        ),
        Bind.factory<UserRepository>(
          (i) => UserRepository(datasource: i.get<UserDatasource>()),
        ),
        Bind.factory<UserUsecase>(
          (i) => UserUsecase(repository: i.get<UserRepository>()),
        ),

        /// Controllers
        Bind.lazySingleton<AuthController>(
          (i) => AuthController(
            redirectTo: _redirectTo,
            onLoginCallback: _onLoginCallback,
            localUserUsecase: i.get<LocalUserUsecase>(),
          ),
        ),
      ];

  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const AuthPage()),
    ModuleRoute(AuthRoutes.login.path, module: LoginModule()),
  ];
}
