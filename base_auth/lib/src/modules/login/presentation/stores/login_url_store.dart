import 'package:core/core.dart'
    show NotifierStore, HttpDriverResponse, Disposable, Either;

import '../../../auth/domain/usecases/microsoft_sso_usecase.dart';

class LoginUrlStore extends NotifierStore<HttpDriverResponse, String>
    with Disposable {
  final IMicrosoftSSOUsecase store;

  LoginUrlStore({required this.store}) : super('');

  Future<Either<HttpDriverResponse, String>> getLoginUrl() async {
    update('');
    setLoading(true);
    return await store.getAuthorizeUrl().then((value) {
      value.fold(setError, update);
      return value;
    }).whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    destroy();
  }
}
