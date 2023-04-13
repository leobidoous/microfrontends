import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../home/presentation/home_module.dart';
import '../../home/presentation/home_router_guard.dart';
import '../../shared/presentation/pages/splash/splash_page.dart';
import '../data/datasources/search_postal_code_datasource.dart';
import '../infra/repositories/search_postal_code_repository.dart';
import '../infra/usecases/search_postal_code_usecase.dart';
import 'app_routes.dart';
import 'controllers/app_controller.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    /// GraphQl
    Bind.factory(
      (i) => GraphQLClient(
        link: Link.from([]),
        cache: GraphQLCache(store: HiveStore()),
      ),
    ),
    Bind.factory(
      (i) => GraphQlClientDriver(
        baseUrl: DM.i.get<EnvironmentEntity>().endpointGraphql,
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
        client: DM.i.get<GraphQLClient>(),
      ),
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
    Bind.factory((i) => Dio(DM.i.get<BaseOptions>())),
    Bind.factory(
      (i) => DioClientDriver(
        client: DM.i.get<Dio>()
          ..options.baseUrl = DM.i.get<EnvironmentEntity>().appBaseUrl
          ..interceptors.addAll(
            [
              LogInterceptor(requestBody: true),
              DioAuthInterceptor(
                authUsecase: DM.i.get<AuthUsecase>(),
                localUserUsecase: DM.i.get<LocalUserUsecase>(),
              ),
            ],
          ),
      ),
    ),

    /// Postal code search
    Bind.factory(
      (i) => SearchPostalCodeDatasource(
        client: DioClientDriver(client: Dio(DM.i.get<BaseOptions>())),
      ),
    ),
    Bind.factory(
      (i) => SearchPostalCodeRepository(
        datasource: DM.i.get<SearchPostalCodeDatasource>(),
      ),
    ),
    Bind.factory(
      (i) => SearchPostalCodeUsecase(
        repository: DM.i.get<SearchPostalCodeRepository>(),
      ),
    ),

    /// Local user
    Bind.factory(
      (i) => LocalUserDatasource(
        prefsDriver: DM.i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.factory(
      (i) => LocalUserRepository(datasource: DM.i.get<LocalUserDatasource>()),
    ),
    Bind.factory(
      (i) => LocalUserUsecase(repository: DM.i.get<LocalUserRepository>()),
    ),

    /// Firebase
    Bind.lazySingleton((i) => GlobalConfigs.firebaseAuth),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseDriver),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseStorage),
    Bind.lazySingleton((i) => GlobalConfigs.crashlyticsDriver),
    Bind.lazySingleton((i) => GlobalConfigs.firebaseNotificationsDriver),

    /// Local notification
    Bind.lazySingleton((i) => GlobalConfigs.localNotificationsDriver),
    Bind.lazySingleton((i) => GlobalConfigs.localNotificationsService),

    /// Preferences storage
    Bind.lazySingleton((i) => GlobalConfigs.preferencesStorageDriver),

    /// Controllers
    Bind.lazySingleton(
      (i) => AppController(localUserUsecase: DM.i.get<LocalUserUsecase>()),
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
      AuthRoutes.root.path,
      module: AuthModule(
        onLoginCallback: () async {},
        redirectTo: AppRoutes.home,
      ),
      guards: [AuthRouterGuard(path: AppRoutes.home)],
    ),
  ];
}

class GlobalConfigs {
  static final GlobalConfigs _singleton = GlobalConfigs._internal();

  factory GlobalConfigs() => _singleton;

  GlobalConfigs._internal();

  /// Firebase global configs
  static FirebaseDriver get firebaseDriver => FirebaseDriver();
  static FirebaseStorageDriver get firebaseStorage => FirebaseStorageDriver(
        instance: FirebaseFirestore.instance,
      );
  static FirebaseCrashlyticsDriver get crashlyticsDriver =>
      FirebaseCrashlyticsDriver(instance: FirebaseCrashlytics.instance);
  static FirebaseNotificationsDriver get firebaseNotificationsDriver =>
      FirebaseNotificationsDriver(
        crashlyticsDriver: crashlyticsDriver,
        instance: FirebaseMessaging.instance,
        localNotificationsDriver: localNotificationsDriver,
      );
  static FirebaseAuthDriver get firebaseAuth => FirebaseAuthDriver(
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
