import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../data/datasources/auth_datasource.dart';
import '../../../infra/repositories/auth_repository.dart';
import '../../../infra/usecases/auth_usecase.dart';
import '../../controllers/auth/auth_controller.dart';

class AuthBindings extends Bindings {
  static void export() {
    /// Auth
    Factory<AuthDatasource>(
      () => AuthDatasource(
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
    );
    Factory<AuthRepository>(
      () => AuthRepository(datasource: DM.i.get<AuthDatasource>()),
    );
    Factory<AuthUsecase>(
      () => AuthUsecase(repository: DM.i.get<AuthRepository>()),
    );
  }

  @override
  void dependencies() {
    export();

    /// Controllers
    Factory<AuthController>(
      () => AuthController(mixpanel: DM.i.get<MixPanelController>()),
    );
  }
}
