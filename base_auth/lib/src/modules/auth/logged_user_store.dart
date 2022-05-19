import 'dart:developer';

import 'package:core/core.dart';

class LoggedUserStore extends NotifierStore<Exception, bool> {
  late final LoggedUserEntity loggedUser;

  LoggedUserStore() : super(false);

  Future<void> updateLoggedUser(LoggedUserEntity loggedUser) async {
    log('LoggedUserStore hashCode: $hashCode');
    this.loggedUser = loggedUser;
    /// Garante que a instância de `loggedUser` foi inicializada
    update(true);
  }
}
