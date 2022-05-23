import 'package:base_auth/base_auth.dart';
import 'package:base_auth/src/modules/login/domain/entities/login/login_with_email_entity.dart';
import 'package:base_auth/src/modules/login/domain/usecases/login/login_with_email.dart';
import 'package:base_auth/src/modules/login/infra/datasources/login/local/local_login_with_email_datasource.dart';
import 'package:base_auth/src/modules/login/infra/datasources/login/remote/remote_login_with_email_datasource.dart';
import 'package:base_auth/src/modules/login/infra/repositories/login/login_with_email_repository.dart';
import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_with_email_test.mocks.dart';

@GenerateMocks([
  ILoggedUserDatasource,
  ILocalLoginWithEmailDatasource,
  IRemoteLoginWithEmailDatasource,
  IConnectivityDriver
])
void main() {
  final connectivityDriverMock = MockIConnectivityDriver();
  final loggedUserDatasourceMock = MockILoggedUserDatasource();
  final localEmailDatasourceMock = MockILocalLoginWithEmailDatasource();
  final remoteEmailDatasourceMock = MockIRemoteLoginWithEmailDatasource();

  test('Deve realizar login com email', () async {
    final login = LoginWithEmailEntity(
      email: 'leonardo@bido.com',
      password: '',
    );
    final connectivityService = ConnectivityService(
      driver: connectivityDriverMock,
    );
    final repository = LoginWithEmailRepository(
      remoteDatasource: remoteEmailDatasourceMock,
      localDatasource: localEmailDatasourceMock,
      connectivityService: connectivityService,
    );
    when(remoteEmailDatasourceMock(login: login)).thenAnswer(
      (_) async => const Right(unit),
    );
    when(connectivityDriverMock.isOnline).thenAnswer((_) async => true);
    when(loggedUserDatasourceMock.saveLoggedUser(user: anyNamed('user')))
        .thenAnswer((_) async => const Right(unit));
    final usecase = LoginWithEmailUsecase(repository: repository);
    when(usecase(login: login)).thenAnswer((_) async => const Right(unit));
    final response = await usecase(login: login);
    expect(response.isRight(), true);
  });
}
