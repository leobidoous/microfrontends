import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

import '../../../../stores/app_store.dart';

class SplashStore extends NotifierStore<Exception, bool> with Disposable {
  final ILoggedUserUsecase loggedUserUsecase;
  final IMicrosoftSSOUsecase ssoUsecase;
  final AppStore appStore;

  SplashStore({
    required this.loggedUserUsecase,
    required this.ssoUsecase,
    required this.appStore,
  }) : super(false);

  Future<void> getLoggedlUser() async {
    setLoading(true);
    await appStore.themeStore.getStorageTheme();
    await loggedUserUsecase.getSavedUser().then((value) {
      return value.fold(
        setError,
        (user) async {
          return await ssoUsecase
              .refreshToken(token: user.graphToken.refreshToken)
              .then(
            (value) {
              return value.fold(
                (l) => setError(Exception(l)),
                (token) async {
                  return await ssoUsecase.getUserDetails(token: token).then(
                        (value) => value.fold(
                          (l) => setError(Exception(l)),
                          (r) => update(true),
                        ),
                      );
                },
              );
            },
          );
        },
      );
    }).whenComplete(() => setLoading(false));
  }

  @override
  void dispose() {
    destroy();
  }
}
