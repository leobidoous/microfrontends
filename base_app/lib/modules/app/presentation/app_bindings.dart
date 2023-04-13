import 'package:cloud_functions/cloud_functions.dart';
import 'package:core/core.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/datasources/local_user_datasource.dart';
import '../data/datasources/search_postal_code_datasource.dart';
import '../data/datasources/user_datasource.dart';
import '../data/drivers/dio_client_driver.dart';
import '../data/drivers/firebase/firebase_crashlytics_driver.dart';
import '../data/drivers/firebase/firebase_driver.dart';
import '../data/drivers/firebase/firebase_notifications_driver.dart';
import '../data/drivers/firebase/firebase_storage_driver.dart';
import '../data/drivers/graphql_client_driver.dart';
import '../data/drivers/local_notifications_driver.dart';
import '../data/drivers/preferences_storage_driver.dart';
import '../domain/entities/environment_entity.dart';
import '../domain/entities/received_notifications_entity.dart';
import '../domain/services/i_graphql_service.dart';
import '../infra/repositories/local_user_repository.dart';
import '../infra/repositories/search_postal_code_repository.dart';
import '../infra/repositories/user_repository.dart';
import '../infra/services/graphql_service.dart';
import '../infra/services/local_notifications_service.dart';
import '../infra/usecases/local_user_usecase.dart';
import '../infra/usecases/search_postal_code_usecase.dart';
import '../infra/usecases/user_usecase.dart';
import 'controllers/app_controller.dart';

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

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// Auth
    AuthBindings.export();

    /// GraphQl
    Factory<GraphQLClient>(
      () => GraphQLClient(
        link: Link.from([]),
        cache: GraphQLCache(store: HiveStore()),
      ),
    );
    Factory<GraphQlClientDriver>(
      () => GraphQlClientDriver(
        baseUrl: DM.i.get<EnvironmentEntity>().endpointGraphql,
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
        client: DM.i.get<GraphQLClient>(),
      )..interceptor = GraphQlAuthInterceptor(
          authUsecase: DM.i.get<AuthUsecase>(),
          localUserUsecase: DM.i.get<LocalUserUsecase>(),
        ),
    );

    /// Http client | Dio
    Factory<BaseOptions>(
      () => BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        sendTimeout: 15000,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
      ),
    );
    Factory<Dio>(() => Dio(DM.i.get<BaseOptions>()));
    Factory<DioClientDriver>(
      () => DioClientDriver(
        client: DM.i.get<Dio>()
          ..options.baseUrl = DM.i.get<EnvironmentEntity>().appBaseUrl
          ..interceptors.addAll(
            [
              LogInterceptor(requestBody: true),
              DioAuthInterceptor(
                authUsecase: DM.i.get<AuthUsecase>(),
                localUserUsecase: DM.i.get<LocalUserUsecase>(),
                authController: DM.i.get<GlobalAuthController>(),
              ),
            ],
          ),
      ),
    );

    /// Postal code search
    Factory<SearchPostalCodeDatasource>(
      () => SearchPostalCodeDatasource(
        client: DioClientDriver(client: Dio(DM.i.get<BaseOptions>())),
      ),
    );
    Factory<SearchPostalCodeRepository>(
      () => SearchPostalCodeRepository(
        datasource: DM.i.get<SearchPostalCodeDatasource>(),
      ),
    );
    Factory<SearchPostalCodeUsecase>(
      () => SearchPostalCodeUsecase(
        repository: DM.i.get<SearchPostalCodeRepository>(),
      ),
    );

    /// Local user
    Factory<LocalUserDatasource>(
      () => LocalUserDatasource(
        prefsDriver: DM.i.get<PreferencesStorageDriver>(),
      ),
    );
    Factory<LocalUserRepository>(
      () => LocalUserRepository(datasource: DM.i.get<LocalUserDatasource>()),
    );
    Factory<LocalUserUsecase>(
      () => LocalUserUsecase(repository: DM.i.get<LocalUserRepository>()),
    );

    /// Remote user
    Factory<UserDatasource>(
      () => UserDatasource(
        graphQlClient: DM.i.get<GraphQlClientDriver>(),
        firebaseAuthDriver: DM.i.get<FirebaseAuthDriver>(),
      ),
    );
    Factory<UserRepository>(
      () => UserRepository(datasource: DM.i.get<UserDatasource>()),
    );
    Factory<UserUsecase>(
      () => UserUsecase(repository: DM.i.get<UserRepository>()),
    );

    /// Firebase
    LazySingleton(() => GlobalConfigs.firebaseAuth);
    LazySingleton(() => GlobalConfigs.firebaseDriver);
    LazySingleton(() => GlobalConfigs.firebaseStorage);
    LazySingleton(() => GlobalConfigs.crashlyticsDriver);
    LazySingleton(() => GlobalConfigs.firebaseNotificationsDriver);

    /// Local notification
    LazySingleton(() => GlobalConfigs.localNotificationsDriver);
    LazySingleton(() => GlobalConfigs.localNotificationsService);

    /// Preferences storage
    LazySingleton(() => GlobalConfigs.preferencesStorageDriver);

    /// Controllers
    LazySingleton<AppController>(
      () => AppController(localUserUsecase: DM.i.get<LocalUserUsecase>()),
    );

    // TODO: remove when migrate from Cloud Function
    LazySingleton<FirebaseHelper>(
      () => FirebaseHelper(FirebaseFirestore.instance),
    );
    LazySingleton<FirebaseFunctions>(() => FirebaseFunctions.instance);

    // TODO: remove Get injection
    LazySingleton<GlobalController>(() => Get.find<GlobalController>());
    LazySingleton<GlobalAuthController>(() => Get.find<GlobalAuthController>());
    LazySingleton<MixPanelController>(() => Get.find<MixPanelController>());

    // TODO: remover quando retirar toda injecao de dependencia via GetX
    Get.put(GlobalController());
    Get.put(
      GlobalAuthController(
        localUserUsecase: DM.i.get<LocalUserUsecase>(),
        globalController: DM.i.get<GlobalController>(),
        appController: DM.i.get<AppController>(),
        authUsecase: DM.i.get<AuthUsecase>(),
      ),
    );
    Get.put(MixPanelController());
    Get.put(GenshopRepository());
  }
}
