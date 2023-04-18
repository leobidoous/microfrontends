import 'package:auth/auth.dart';
import 'package:core/core.dart';

import '../../home/presentation/home_router_guard.dart';
import '../../home/presentation/modules/home_module.dart';
import '../../home/presentation/routes/dashboard_routes.dart';
import '../../home/presentation/routes/home_routes.dart';
import '../../shared/presentation/controllers/splash_controller.dart';
import '../../shared/presentation/pages/fallback_page.dart';
import '../../shared/presentation/pages/feat_comming_soon_page.dart';
import '../../shared/presentation/pages/splash_page.dart';
import '../../shared/presentation/shared_routes.dart';
import 'app_configuration.dart';
import 'app_routes.dart';
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
    Bind.singleton<AppConfiguration>((i) => _appConfiguration),
    Bind.singleton<EnvironmentEntity>((i) => _appConfiguration.environment),

    /// GraphQl
    Bind.factory<GraphQLClient>(
      (i) => GraphQLClient(
        link: Link.from([]),
        cache: GraphQLCache(store: HiveStore()),
      ),
    ),
    Bind.factory<GraphQlClientDriver>(
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
    Bind.factory<BaseOptions>(
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
    Bind.factory<Dio>((i) => Dio(i.get<BaseOptions>())),
    Bind.factory<DioClientDriver>(
      (i) => DioClientDriver(
        client: i.get<Dio>()
          ..options.baseUrl = i.get<EnvironmentEntity>().appBaseUrl
          ..interceptors.addAll(
            [
              LogInterceptor(requestBody: false),
              DioAuthInterceptor(
                authUsecase: i.get<AuthUsecase>(),
                localUserUsecase: i.get<LocalUserUsecase>(),
              ),
            ],
          ),
      ),
    ),

    /// Search zip code
    Bind.factory<SearchPostalCodeDatasource>(
      (i) => SearchPostalCodeDatasource(
        client: DioClientDriver(client: Dio(i.get<BaseOptions>())),
      ),
    ),
    Bind.factory<SearchPostalCodeRepository>(
      (i) => SearchPostalCodeRepository(
        datasource: i.get<SearchPostalCodeDatasource>(),
      ),
    ),
    Bind.factory<SearchPostalCodeUsecase>(
      (i) => SearchPostalCodeUsecase(
        repository: i.get<SearchPostalCodeRepository>(),
      ),
    ),

    /// Local user
    Bind.factory<LocalUserDatasource>(
      (i) => LocalUserDatasource(
        prefsDriver: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.factory<LocalUserRepository>(
      (i) => LocalUserRepository(datasource: i.get<LocalUserDatasource>()),
    ),
    Bind.factory<LocalUserUsecase>(
      (i) => LocalUserUsecase(repository: i.get<LocalUserRepository>()),
    ),

    /// Firebase
    Bind.lazySingleton<FirebaseDriver>((i) => GlobalConfigs.firebaseDriver),
    Bind.lazySingleton<FirebaseAuthDriver>(
      (i) => GlobalConfigs.firebaseAuthDriver,
    ),
    Bind.lazySingleton<FirebaseCrashlyticsDriver>(
      (i) => GlobalConfigs.crashlyticsDriver,
    ),
    Bind.lazySingleton<FirebaseStorageDriver>(
      (i) => GlobalConfigs.firebaseStorageDriver,
    ),
    Bind.lazySingleton<FirebaseNotificationsDriver>(
      (i) => GlobalConfigs.firebaseNotificationsDriver,
    ),

    /// Local notification
    Bind.factory<LocalNotificationsDriver>(
      (i) => GlobalConfigs.localNotificationsDriver,
    ),
    Bind.lazySingleton<LocalNotificationsService>(
      (i) => GlobalConfigs.localNotificationsService,
    ),

    /// Location
    Bind.factory<LocationService>((i) => GlobalConfigs.locationService),
    Bind.factory<LocationDriver>((i) => GlobalConfigs.locationDriver),

    /// Permissions
    Bind.factory<PermissionService>((i) => GlobalConfigs.permissionService),

    /// Preferences storage
    Bind.lazySingleton<PreferencesStorageDriver>(
      (i) => GlobalConfigs.preferencesStorageDriver,
    ),

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
    Bind.factory<SplashController>(
      (i) => SplashController(
        appController: i.get<AppController>(),
        userUsecase: i.get<UserUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.root.path, child: (_, args) => const SplashPage()),
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
    ChildRoute(
      SharedRoutes.comming.completePath,
      transition: TransitionType.downToUp,
      child: (_, args) => const FeatCommingSoonPage(),
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

  /// Location
  static LocationDriver get locationDriver => LocationDriver();
  static LocationService get locationService => LocationService();

  /// Permission
  static PermissionService get permissionService => PermissionService();

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
