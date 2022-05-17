import 'dart:developer';

import 'package:core/core.dart';

class SplashStore extends NotifierStore<Exception, bool> with Disposable {
  SplashStore() : super(false);

  Future<void> getLoggedlUser() async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      // update(true);
      setLoading(false);
    }).catchError((onError) {
      setLoading(false);
      setError(Exception('Erro qualquer!'));
    });
  }

  @override
  void dispose() {
    log('disposable');
  }
}
