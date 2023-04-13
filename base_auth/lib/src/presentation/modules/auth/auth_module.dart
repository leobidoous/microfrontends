import 'package:core/core.dart';

import '../../../data/datasources/auth_datasource.dart';
import '../../../infra/repositories/auth_repository.dart';
import '../../../infra/usecases/auth_usecase.dart';
import '../../controllers/auth/auth_controller.dart';
import '../../pages/auth/auth_page.dart';

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

  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => AuthDatasource(
        client: DioClientDriver(
          client: Dio()
            ..options.baseUrl = DM.i.get<EnvironmentEntity>().baseUrlParking
            ..interceptors.addAll([LogInterceptor(requestBody: true)]),
        ),
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
        graphQlClient: GraphQlClientDriver(
          baseUrl: DM.i.get<EnvironmentEntity>().endpointGraphql,
          localUserUsecase: DM.i.get<LocalUserUsecase>(),
          client: GraphQLClient(
            link: Link.from([]),
            cache: GraphQLCache(store: HiveStore()),
          ),
        ),
        firebaseAuthDriver: DM.i.get<FirebaseAuthDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => AuthRepository(datasource: DM.i.get<AuthDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => AuthUsecase(repository: DM.i.get<AuthRepository>()),
    ),

    /// Controllers
    Bind.lazySingleton(
      (i) => AuthController(
        redirectTo: _redirectTo,
        onLoginCallback: _onLoginCallback,
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const AuthPage()),
  ];
}
