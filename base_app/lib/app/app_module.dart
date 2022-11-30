import 'package:base_auth/base_auth.dart'
    show
        AuthInterceptor,
        AuthModule,
        LoggedUserDatasource,
        LoggedUserRepository,
        LoggedUserUsecase,
        LogoutDatasource,
        LogoutRepository,
        LogoutUsecase,
        MicrosoftSSODatasource,
        MicrosoftSSORepository,
        MicrosoftSSOUsecase;
import 'package:core/core.dart'
    show
        BaseOptions,
        BehaviorSubject,
        Bind,
        ChildRoute,
        Connectivity,
        ConnectivityDriver,
        ConnectivityService,
        DefaultInterceptor,
        Dio,
        DioClientDriver,
        FirebaseAnalytics,
        FirebaseCrashlytics,
        FirebaseDriver,
        FirebaseFirestore,
        FirebaseMessaging,
        FirebaseNotificationsDriver,
        FirebaseStorageDriver,
        LocalNotificationsDriver,
        LocalNotificationsService,
        LocalStorageDriver,
        ModularRoute,
        Module,
        ModuleRoute,
        NotFoundPage,
        NotificationResponse,
        PreferencesStorageDriver,
        ReceivedNotificationEntity,
        TransitionType,
        WildcardRoute;

import '../core/constants/environment.dart';
import '../core/router_guards/auth_router_guards.dart';
import '../core/router_guards/logged_router_guard.dart';
import '../main.dart';
import 'app_routes.dart';
import 'modules/home/presentation/home_module.dart';
import 'modules/home/presentation/home_routes.dart';
import 'shared/presentation/views/splash/splash_page.dart';
import 'shared/presentation/views/splash/splash_store.dart';
import 'stores/app_store.dart';
import 'stores/app_theme_store.dart';
import 'stores/user_store.dart';

final firebaseDriver = FirebaseDriver();
final localNotificationsDriver = LocalNotificationsDriver(
  onDidReceiveLocalNotification: BehaviorSubject<ReceivedNotificationEntity>(),
  selectNotificationSubject: BehaviorSubject<NotificationResponse>(),
);
final localNotificationsService = LocalNotificationsService(
  localNotificationsDriver: localNotificationsDriver,
);

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    /// Firebase dependencies
    Bind.singleton((i) => firebaseDriver),
    Bind.singleton((i) => localNotificationsDriver),
    Bind.singleton((i) => localNotificationsService),
    Bind.lazySingleton((i) => FirebaseAnalytics.instance),
    Bind.lazySingleton((i) => FirebaseCrashlytics.instance),
    Bind.factory(
      (i) => FirebaseStorageDriver(instance: FirebaseFirestore.instance),
    ),
    Bind.lazySingleton(
      (i) => FirebaseNotificationsDriver(
        instance: FirebaseMessaging.instance,
        localNotificationsService: i.get<LocalNotificationsService>(),
      ),
    ),

    /// Global configs dependencies
    Bind.lazySingleton((_) => appConfiguration.environment),
    Bind.lazySingleton(
      (i) => DioClientDriver(
        client: Dio(
          BaseOptions(
            baseUrl: i.get<Environment>().baseUrl ?? '',
            connectTimeout: 20000,
            receiveTimeout: 20000,
            sendTimeout: 20000,
            headers: {
              'X-RapidAPI-Key':
                  '6bda672992msha6d4ba0c89598ddp11b8e7jsnb3589017681e',
              'X-RapidAPI-Host': 'yahfinances.p.rapidapi.com'
            },
          ),
        )..interceptors.addAll(
            [
              DefaultInterceptor(),
              AuthInterceptor(
                ssoUsecase: i.get<MicrosoftSSOUsecase>(),
                loggedUserUsecase: i.get<LoggedUserUsecase>(),
                client: DioClientDriver(
                  client: Dio(
                    BaseOptions(
                      connectTimeout: 20000,
                      receiveTimeout: 20000,
                      sendTimeout: 20000,
                    ),
                  )..interceptors.add(DefaultInterceptor()),
                ),
              ),
            ],
          ),
      ),
    ),
    Bind.lazySingleton((i) => PreferencesStorageDriver()),
    Bind.lazySingleton((i) => LocalStorageDriver()),
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

    /// Microsoft SSO dependencies
    Bind.lazySingleton(
      (i) => MicrosoftSSODatasource(
        client: DioClientDriver(
          client: Dio(
            BaseOptions(
              connectTimeout: 20000,
              receiveTimeout: 20000,
              sendTimeout: 20000,
            ),
          )..interceptors.add(DefaultInterceptor()),
        ),
        loggedUserUsecase: i.get<LoggedUserUsecase>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => MicrosoftSSORepository(
        datasource: i.get<MicrosoftSSODatasource>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => MicrosoftSSOUsecase(
        repository: i.get<MicrosoftSSORepository>(),
      ),
    ),

    /// Logout dependencies
    Bind.lazySingleton(
      (i) => LogoutDatasource(usecase: i.get<LoggedUserUsecase>()),
    ),
    Bind.lazySingleton(
      (i) => LogoutRepository(datasource: i.get<LogoutDatasource>()),
    ),
    Bind.lazySingleton(
      (i) => LogoutUsecase(repository: i.get<LogoutRepository>()),
    ),

    /// Stores dependencies
    Bind.lazySingleton((i) => UserStore()),
    Bind.lazySingleton(
      (i) => SplashStore(
        appStore: i.get<AppStore>(),
        ssoUsecase: i.get<MicrosoftSSOUsecase>(),
        loggedUserUsecase: i.get<LoggedUserUsecase>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => AppThemeStore(
        preferencesDriver: i.get<PreferencesStorageDriver>(),
      ),
    ),
    Bind.lazySingleton(
      (i) => AppStore(
        themeStore: i.get<AppThemeStore>(),
        logoutUsecase: i.get<LogoutUsecase>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(AppRoutes.root.path, child: (_, args) => const SplashPage()),
    ModuleRoute(
      AppRoutes.main.path,
      module: HomeModule(),
      transition: TransitionType.fadeIn,
      guards: [LoggedRouterGuard()],
    ),
    ModuleRoute(
      AppRoutes.auth.path,
      module: AuthModule()..setNextPage(path: HomeRoutes.home),
      transition: TransitionType.fadeIn,
      guards: [AuthRouterGuard()],
    ),
    WildcardRoute(child: (_, args) => const NotFoundPage()),
  ];
}
