import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../../shared/presentation/pages/splash/splash_controller.dart';
import '../../../shared/presentation/pages/splash/splash_page.dart';
import '../../home/presentation/home_module.dart';
import '../../home/presentation/home_router_guard.dart';
import '../data/datasources/user_datasource.dart';
import '../domain/usecases/user_usecase.dart';
import '../infra/repositories/user_repository.dart';
import 'app_configuration.dart';
import 'app_controller.dart';
import 'app_routes.dart';

class GlobalConfigs {
  static final GlobalConfigs _singleton = GlobalConfigs._internal();

  factory GlobalConfigs() => _singleton;

  GlobalConfigs._internal();

  /// Firebase global configs
  static FirebaseDriver get firebaseDriver => FirebaseDriver();
  static FirebaseCrashlyticsDriver get crashlyticsDriver =>
      FirebaseCrashlyticsDriver(instance: FirebaseCrashlytics.instance);
  static FirebaseNotificationsDriver get firebaseNotificationsDriver =>
      FirebaseNotificationsDriver(
        crashlyticsDriver: crashlyticsDriver,
        instance: FirebaseMessaging.instance,
        localNotificationsDriver: localNotificationsDriver,
      );

  /// Local notification global configs
  static LocalNotificationsDriver get localNotificationsDriver =>
      LocalNotificationsDriver(
        onReceiveNotification: BehaviorSubject<ReceivedNotificationEntity>(),
        selectNotificationSubject: BehaviorSubject<NotificationResponse>(),
      );
  static LocalNotificationsService get localNotificationsService =>
      LocalNotificationsService(
        localNotificationsDriver: localNotificationsDriver,
      );
}

class AppModule extends Module {
  static late final AppConfiguration _appConfiguration;

  AppModule({required AppConfiguration appConfiguration}) {
    _appConfiguration = appConfiguration;
  }

  @override
  final List<Bind> binds = [
    /// Global
    Bind.factory(
      (i) => BaseOptions(
        baseUrl: _appConfiguration.environment.baseUrl,
        sendTimeout: 20000,
        connectTimeout: 20000,
        receiveTimeout: 20000,
      ),
    ),
    Bind.singleton(
      (i) => DioClientDriver(
        client: Dio(
          DM.i.get<BaseOptions>(),
        )..interceptors.addAll([
            AuthInterceptor(
              localUserUsecase: DM.i.get<LocalUserUsecase>(),
              logoutUsecase: DM.i.get<LogoutUsecase>(),
              tokenUsecase: DM.i.get<TokenUsecase>(),
            ),
            LogInterceptor(requestBody: true),
          ]),
      ),
    ),

    /// Token
    Bind.lazySingleton(
      (i) => TokenDatasource(
        client: DioClientDriver(
          client: Dio(DM.i.get<BaseOptions>())
            ..interceptors.add(LogInterceptor(requestBody: true)),
        ),
      ),
    ),
    Bind.lazySingleton(
      (i) => TokenRepository(datasource: DM.i.get<TokenDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => TokenUsecase(repository: DM.i.get<TokenRepository>()),
    ),

    /// App configuration and environment
    Bind.singleton((i) => _appConfiguration),
    Bind.singleton((i) => _appConfiguration.environment),

    /// Firebase
    Bind.singleton((i) => GlobalConfigs.firebaseDriver),
    Bind.lazySingleton((i) => GlobalConfigs.crashlyticsDriver),
    Bind.singleton((i) => GlobalConfigs.localNotificationsDriver),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseNotificationsDriver),

    /// Stores
    Bind.lazySingleton((i) => AppController()),
    Bind.lazySingleton(
      (i) => SplashController(
        userUsecase: DM.i.get<UserUsecase>(),
        appController: DM.i.get<AppController>(),
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
      ),
    ),

    /// Logout
    Bind.lazySingleton(
      (i) => LogoutDatasource(usecase: DM.i.get<LocalUserUsecase>()),
    ),
    Bind.lazySingleton(
      (i) => LogoutRepository(datasource: DM.i.get<LogoutDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => LogoutUsecase(repository: DM.i.get<LogoutRepository>()),
    ),

    /// User
    Bind.lazySingleton(
      (i) => UserDatasource(client: DM.i.get<DioClientDriver>()),
    ),
    Bind.lazySingleton(
      (i) => UserRepository(datasource: DM.i.get<UserDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => UserUsecase(repository: DM.i.get<UserRepository>()),
    ),

    /// Local user
    Bind.lazySingleton((i) => LocalUserDatasource()),
    Bind.lazySingleton(
      (i) => LocalUserRepository(datasource: DM.i.get<LocalUserDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => LocalUserUsecase(repository: DM.i.get<LocalUserRepository>()),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
    ModuleRoute(
      AppRoutes.home.path,
      module: HomeModule(),
      guards: [HomeRouterGuard()],
    ),
    ModuleRoute(
      AppRoutes.auth.path,
      module: AuthModule(
        redirectTo: AppRoutes.home,
        onLoginCallback: (user) async {
          DM.i.get<AppController>().user = user;
        },
      ),
      guards: [AuthRouterGuard(path: AppRoutes.home)],
    ),
  ];
}
