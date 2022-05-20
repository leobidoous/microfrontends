import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

class SplashStore extends NotifierStore<Exception, bool> with Disposable {
  final ILoggedUserUsecase loggedUserUsecase;
  final LoggedUserStore userStore;

  SplashStore({
    required this.loggedUserUsecase,
    required this.userStore,
  }) : super(false);

  Future<void> getLoggedlUser() async {
    setLoading(true);
    await loggedUserUsecase.getLoggedUser().then((value) {
      value.fold(
        (l) => setError(l),
        (r) {
          userStore.updateLoggedUser(r);
          update(true);
        },
      );
    });
    setLoading(false);
  }

  @override
  void dispose() {
    destroy();
  }
}
