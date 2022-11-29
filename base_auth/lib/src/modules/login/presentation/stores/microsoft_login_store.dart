import 'package:core/core.dart'
    show NotifierStore, HttpDriverResponse, Disposable;

import '../../../auth/domain/usecases/microsoft_sso_usecase.dart';

class MicrosoftLoginStore extends NotifierStore<HttpDriverResponse, bool>
    with Disposable {
  final IMicrosoftSSOUsecase ssoUsecase;

  MicrosoftLoginStore({required this.ssoUsecase}) : super(false);

  Future<void> login({required String code}) async {
    update(false);
    setLoading(true);
    return await ssoUsecase.getToken(code: code).then((value) {
      return value.fold(
        setError,
        (r) async {
          await ssoUsecase.getUserDetails(token: r).then((value) {
            return value.fold(setError, (r) => update(true));
          });
        },
      );
    }).whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    destroy();
  }
}
