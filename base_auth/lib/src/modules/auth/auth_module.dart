import 'package:core/core.dart';

import '../../core/app_routes.dart';
import '../login/data/datasources/login/local/local_login_with_email_datasource.dart';
import '../login/data/datasources/login/local/local_login_with_phone_datasource.dart';
import '../login/data/datasources/login/remote/remote_login_with_email_datasource.dart';
import '../login/data/datasources/login/remote/remote_login_with_phone_datasource.dart';
import '../login/domain/usecases/login/login_with_email.dart';
import '../login/domain/usecases/login/login_with_phone.dart';
import '../login/infra/repositories/login/login_with_email_repository.dart';
import '../login/infra/repositories/login/login_with_phone_repository.dart';
import '../login/presentation/login_page.dart';
import '../login/presentation/stores/login_store.dart';
import '../login/presentation/stores/login_type_store.dart';
import 'data/datasources/logged_user_datasource.dart';
import 'domain/usecases/logged_user_usecase.dart';
import 'infra/repositories/logged_user_repository.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    /// Connectivity dependencies
    Bind.lazySingleton((i) => Connectivity()),
    Bind.lazySingleton(
      (i) => ConnectivityDriver(connectivity: i.get<Connectivity>()),
    ),
    Bind.lazySingleton(
      (i) => ConnectivityService(driver: i.get<ConnectivityDriver>()),
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

    /// Local storage dependencies
    Bind.lazySingleton((i) => LocalStorageDriver()),

    /// Login with phone dependencies
    Bind.lazySingleton((i) => LocalLoginWithPhoneDatasource()),
    Bind.lazySingleton(
      (i) => RemoteLoginWithPhoneDatasource(
        loggedUserDatasource: i.get<LoggedUserDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => LoginWithPhoneRepository(
        localDatasource: i.get<LocalLoginWithPhoneDatasource>(),
        remoteDatasource: i.get<RemoteLoginWithPhoneDatasource>(),
        connectivityService: i.get<IConnectivityService>(),
      ),
    ),
    Bind.lazySingleton((i) => LoginWithPhoneUsecase(repository: i.get())),

    /// Login with email dependencies
    Bind.lazySingleton((i) => LocalLoginWithEmailDatasource()),
    Bind.lazySingleton(
      (i) => RemoteLoginWithEmailDatasource(
        loggedUserDatasource: i.get<LoggedUserDatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => LoginWithEmailRepository(
        localDatasource: i.get<LocalLoginWithEmailDatasource>(),
        remoteDatasource: i.get<RemoteLoginWithEmailDatasource>(),
        connectivityService: i.get<IConnectivityService>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => LoginWithEmailUsecase(
        repository: i.get<LoginWithEmailRepository>(),
      ),
    ),

    /// login stores
    Bind.lazySingleton((i) => LoginTypeStore()),
    Bind.lazySingleton(
      (i) => LoginStore(
        emailUsecase: i.get(),
        phoneUsecase: i.get(),
        typeStore: i.get(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) {
        final loginFoward =
            args.data != null ? args.data.toString() : '${AppRoutes.home}/';
        return LoginPage(loginFoward: loginFoward);
      },
    ),
    WildcardRoute(child: (_, args) => const NotFoundPage()),
  ];
}
