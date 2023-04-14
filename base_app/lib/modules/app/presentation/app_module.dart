import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../home/presentation/home_router_guard.dart';
import '../../home/presentation/modules/home_module.dart';
import '../../home/presentation/routes/dashboard_routes.dart';
import '../../home/presentation/routes/home_routes.dart';
import '../../shared/presentation/controllers/splash_controller.dart';
import '../../shared/presentation/pages/fallback_page.dart';
import '../../shared/presentation/pages/splash_page.dart';
import 'app_configuration.dart';
import 'controllers/app_controller.dart';
import 'controllers/theme_controller.dart';

class AppModule extends Module {
  AppModule({required AppConfiguration appConfiguration}) {
    _appConfiguration = appConfiguration;
  }

  static late final AppConfiguration _appConfiguration;

  @override
  final List<Bind> binds = [
    /// Auth
    ...AuthModule.exportedBinds,

    /// App configuration and environment
    Bind.singleton((i) => _appConfiguration),
    Bind.singleton((i) => _appConfiguration.environment),

    /// GraphQl
    Bind.factory(
      (i) => GraphQLClient(
        link: Link.from([]),
        cache: GraphQLCache(store: HiveStore()),
      ),
    ),
    Bind.factory(
      (i) => GraphQlClientDriver(
        baseUrl: i.get<EnvironmentEntity>().endpointGraphql,
        client: i.get<GraphQLClient>(),
      )..interceptors.addAll([
          GraphQlAuthInterceptor(
            authUsecase: i.get<AuthUsecase>(),
            localUserUsecase: i.get<LocalUserUsecase>(),
          ),
        ]),
    ),

    /// Http client | Dio
    Bind.factory(
      (i) => BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        sendTimeout: 15000,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
      ),
    ),
    Bind.factory((i) => Dio(i.get<BaseOptions>())),
    Bind.factory(
      (i) => DioClientDriver(
        client: i.get<Dio>()
          ..options.baseUrl = i.get<EnvironmentEntity>().appBaseUrl
          ..interceptors.addAll(
            [
              LogInterceptor(requestBody: true),
              DioAuthInterceptor(
                authUsecase: i.get<AuthUsecase>(),
                localUserUsecase: i.get<LocalUserUsecase>(),
              ),
            ],
          ),
      ),
    ),

    /// Postal code search
    Bind.factory(
      (i) => SearchPostalCodeDatasource(
        client: DioClientDriver(client: Dio(i.get<BaseOptions>())),
      ),
    ),
    Bind.factory(
      (i) => SearchPostalCodeRepository(
        datasource: i.get<SearchPostalCodeDatasource>(),
      ),
    ),
    Bind.factory(
      (i) => SearchPostalCodeUsecase( 
        repository: i.get<SearchPostalCodeRepository>(),
      ),
    ),

    /// Local user
    Bind.factory(
      (i) => LocalUserDatasource(
        prefsDriver: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.factory(
      (i) => LocalUserRepository(datasource: i.get<LocalUserDatasource>()),
    ),
    Bind.factory(
      (i) => LocalUserUsecase(repository: i.get<LocalUserRepository>()),
    ),

    /// Firebase
    Bind.lazySingleton((i) => GlobalConfigs.firebaseDriver),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseAuthDriver),
    Bind.lazySingleton((i) => GlobalConfigs.crashlyticsDriver),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseStorageDriver),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseNotificationsDriver),

    /// Local notification
    Bind.lazySingleton((i) => GlobalConfigs.localNotificationsDriver),
    Bind.lazySingleton((i) => GlobalConfigs.localNotificationsService),

    /// Preferences storage
    Bind.lazySingleton((i) => GlobalConfigs.preferencesStorageDriver),

    /// Controllers
    Bind.lazySingleton<AppController>(
      (i) => AppController(
        authUsecase: i.get<AuthUsecase>(),
        localUserUsecase: i.get<LocalUserUsecase>(),
      ),
    ),
    Bind.factory<ThemeController>(
      (i) => ThemeController(localUserUsecase: i.get<LocalUserUsecase>()),
    ),
    Bind.factory(
      (i) => SplashController(
        appController: i.get<AppController>(),
        userUsecase: i.get<UserUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => const SplashPage()),
    ModuleRoute(
      HomeRoutes.root.path,
      module: HomeModule(),
      guards: [HomeRouterGuard()],
    ),
    ModuleRoute(
      AuthRoutes.root.path,
      module: AuthModule(
        onLoginCallback: (session) async {
          DM.i.get<AppController>().session = session;
        },
        redirectTo: DashboardRoutes.root,
      ),
      guards: [AuthRouterGuard(path: DashboardRoutes.root)],
    ),
    WildcardRoute(child: (_, args) => const FallbackPage()),
  ];
}

class GlobalConfigs {
  static final GlobalConfigs _singleton = GlobalConfigs._internal();
  factory GlobalConfigs() => _singleton;
  GlobalConfigs._internal();

  /// Firebase global configs
  static FirebaseDriver get firebaseDriver => FirebaseDriver();
  static FirebaseStorageDriver get firebaseStorageDriver =>
      FirebaseStorageDriver(instance: FirebaseFirestore.instance);
  static FirebaseCrashlyticsDriver get crashlyticsDriver =>
      FirebaseCrashlyticsDriver(instance: FirebaseCrashlytics.instance);
  static FirebaseNotificationsDriver get firebaseNotificationsDriver =>
      FirebaseNotificationsDriver(
        crashlyticsDriver: crashlyticsDriver,
        instance: FirebaseMessaging.instance,
        localNotificationsDriver: localNotificationsDriver,
      );
  static FirebaseAuthDriver get firebaseAuthDriver => FirebaseAuthDriver(
        instance: FirebaseAuth.instance,
      );

  /// Preferences storage configs
  static PreferencesStorageDriver get preferencesStorageDriver =>
      PreferencesStorageDriver();

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

  /// GraphQl configs
  static IGraphQlService get graphQlService => GraphQlService();
}
