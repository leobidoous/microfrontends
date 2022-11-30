import 'package:core/core.dart'
    show
        Disposable,
        LoggedUserEntity,
        NotifierStore,
        TokenEntity;

import '../../../auth/domain/usecases/logged_user_usecase.dart';

class FakeLoginStore extends NotifierStore<Exception, bool>
    with Disposable {
  final ILoggedUserUsecase loggedUserUsecase;

  FakeLoginStore({required this.loggedUserUsecase}) : super(false);

  Future<void> login() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1));
    final date = DateTime(DateTime.now().year + 1);
    final tokenFake = TokenEntity(
      accessToken: 'accessToken',
      idToken: 'idToken',
      tokenType: 'tokenType',
      refreshToken: 'refreshToken',
      issueTimeStamp: date,
      expireTimeStamp: date,
      expiresIn: 10000,
    );
    await loggedUserUsecase
        .saveLoggedUser(
          user: LoggedUserEntity(
            id: 'id',
            mail: 'mail',
            surname: 'surname',
            jobTitle: 'jobTitle',
            graphToken: tokenFake,
            givenName: 'givenName',
            displayName: 'displayName',
            mobilePhone: 'mobilePhone',
            sharepointToken: tokenFake,
            officeLocation: 'officeLocation',
            userPrincipalName: 'userPrincipalName',
            preferredLanguage: 'preferredLanguage',
          ),
        ).then((value) => value.fold(setError, (r) => update(true)))
        .whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    destroy();
  }
}
