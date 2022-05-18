import 'dart:developer';

import 'package:base_auth/base_auth.dart';
import 'package:core/core.dart';

class SplashStore extends NotifierStore<Exception, bool> with Disposable {
  final ILoggedUserUsecase loggedUserUsecase;

  SplashStore({required this.loggedUserUsecase}) : super(false);

  Future<void> getLoggedlUser() async {
    setLoading(true);
    await loggedUserUsecase.getLoggedUser().then((value) {
      value.fold((l) => setError(l), (r) => update(true));
    });
    setLoading(false);
  }

  @override
  void dispose() {
    log('disposable');
  }
}
